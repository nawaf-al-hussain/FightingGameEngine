"use client";

import { useEffect, useRef, useState } from "react";
import { loadGameEngine, type GameInstance } from "@/lib/wasm-loader";

/**
 * GameCanvas — renders the Emscripten WASM game inside a canvas element.
 *
 * The game.js loader script creates the canvas and initializes SDL.
 * We dynamically load game.js, which sets up Module and attaches
 * the canvas to the DOM.
 */
export default function GameCanvas() {
  const containerRef = useRef<HTMLDivElement>(null);
  const [status, setStatus] = useState<"loading" | "ready" | "error">("loading");
  const [error, setError] = useState("");
  const gameRef = useRef<GameInstance | null>(null);

  useEffect(() => {
    let destroyed = false;
    let gamePromise: Promise<GameInstance> | null = null;

    async function init() {
      try {
        setStatus("loading");

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
  }, []);

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

      {/* Emscripten appends its own canvas to the body or a target element */}
      <canvas
        id="game-canvas"
        className="game-canvas"
        style={{ display: status === "ready" ? "block" : "none" }}
      />
    </div>
  );
}