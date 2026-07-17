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

    async function init() {
      try {
        setStatus("loading");

        // Dynamically load the Emscripten game.js script
        const script = document.createElement("script");
        script.src = "/game/game.js";
        script.async = true;

        script.onload = async () => {
          if (destroyed) return;

          // Wait a tick for Module to initialize
          await new Promise((r) => setTimeout(r, 100));

          try {
            const game = await loadGameEngine();
            gameRef.current = game;
            if (!destroyed) setStatus("ready");
          } catch (e) {
            if (!destroyed) {
              setError((e as Error).message);
              setStatus("error");
            }
          }
        };

        script.onerror = () => {
          if (!destroyed) {
            setError("Failed to load game.js — WASM build may be missing. Run: npm run build:wasm");
            setStatus("error");
          }
        };

        document.head.appendChild(script);
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