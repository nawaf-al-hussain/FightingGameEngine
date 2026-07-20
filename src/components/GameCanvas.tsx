"use client";

import { useEffect, useRef, useState } from "react";
import { loadGameEngine, type GameInstance } from "@/lib/wasm-loader";

interface GameCanvasProps {
  /** Called once when the WASM engine has finished initializing */
  onReady?: (game: GameInstance) => void;
}

/**
 * GameCanvas — renders the Emscripten WASM game inside a canvas element.
 *
 * The game.js loader script creates the canvas and initializes SDL.
 * We dynamically load game.js, which sets up Module and attaches
 * the canvas to the DOM.
 *
 * The canvas element has id="canvas" (NOT "game-canvas") because Emscripten's
 * SDL2 module looks for `document.getElementById('canvas')` as its default
 * rendering target. Setting Module.canvas also works; we do both for safety.
 */
export default function GameCanvas({ onReady }: GameCanvasProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [status, setStatus] = useState<"loading" | "ready" | "error">("loading");
  const [error, setError] = useState("");
  const gameRef = useRef<GameInstance | null>(null);

  useEffect(() => {
    let destroyed = false;
    let gamePromise: Promise<GameInstance> | null = null;

    async function init() {
      try {
        setStatus("loading");

        // Set Module.canvas BEFORE loading game.js so SDL2 finds it.
        // Emscripten's SDL2 module looks for Module.canvas first, then
        // falls back to document.getElementById('canvas').
        if (canvasRef.current) {
          const w = window as unknown as { Module?: { canvas?: HTMLCanvasElement } };
          if (!w.Module) w.Module = {} as { canvas?: HTMLCanvasElement };
          w.Module.canvas = canvasRef.current;
        }

        // FIX-2: Set up the onRuntimeInitialized callback BEFORE loading
        // game.js. Emscripten picks up window.Module if set before the script
        // boots, and calls onRuntimeInitialized when the WASM runtime is ready.
        // This replaces the old setTimeout(100) race condition that failed on
        // mobile browsers where init takes seconds.
        gamePromise = loadGameEngine();

        const script = document.createElement("script");
        script.src = "/game/game.js";
        script.async = true;

        script.onerror = () => {
          if (!destroyed) {
            setError("Failed to load game.js — WASM build may be missing. Run: npm run build:wasm");
            setStatus("error");
          }
        };

        document.head.appendChild(script);

        try {
          const game = await gamePromise;
          if (destroyed) return;
          gameRef.current = game;
          setStatus("ready");
          // Start the engine manually (noInitialRun = true in wasm-loader).
          // try/catch because emscripten_set_main_loop throws + abortSystem throws.
          try {
            game.Module._main();
          } catch (e) {
            console.error("[GameCanvas] _main() threw:", e);
          }
          onReady?.(game);
        } catch (e) {
          if (!destroyed) {
            setError((e as Error).message);
            setStatus("error");
          }
        }
      } catch (e) {
        if (!destroyed) {
          setError((e as Error).message);
          setStatus("error");
        }
      }
    }

    init();

    return () => {
      destroyed = true;
    };
  }, [onReady]);

  return (
    <div ref={containerRef} className="game-container">
      {status === "loading" && (
        <div className="game-loading">
          <div className="game-loading__spinner" />
          <p>Loading game engine...</p>
        </div>
      )}

      {status === "error" && (
        <div className="game-error">
          <p>Error: {error}</p>
          <p className="game-error__hint">
            Run <code>npm run build:wasm</code> to build the game engine.
          </p>
        </div>
      )}

      {/* Canvas with id="canvas" — what Emscripten/SDL2 looks for by default.
          We also set Module.canvas to this element in init() for redundancy.
          Width/height are set explicitly so SDL2 can initialize even when
          the canvas is display:none during loading. The engine's
          setScreenSize(320, 240) will resize if needed. */}
      <canvas
        ref={canvasRef}
        id="canvas"
        className="game-canvas"
        width={320}
        height={240}
      />
    </div>
  );
}
