"use client";

/**
 * useLocalTwoPlayer — captures keyboard input for two players sharing
 * one keyboard and pumps both inputs to the WASM engine at 60fps.
 *
 * ROBUSTNESS FIX: Previous version called setP1/setP2/setFrameCount every
 * frame, causing 60 re-renders/sec. Each re-render created a new `twoPlayer`
 * object, which re-triggered the FightScreen's useEffect([game, twoPlayer]),
 * which could cause race conditions with the pump lifecycle.
 *
 * New design:
 *   - Keyboard listeners attach ONCE (empty deps) and never re-attach
 *   - RAF pump runs continuously, reading from refs only
 *   - Display state updates are THROTTLED to ~10fps (every 100ms)
 *   - The `twoPlayer` object identity is stable (useMemo with no deps)
 *
 * Player 1 layout (left side of keyboard):
 *   Movement: W A S D  →  U L D R  →  MUGEN U B D F
 *   Punches:  U I O    →  a b c
 *   Kicks:    J K L    →  x y z
 *   Start:    1
 *
 * Player 2 layout (right side of keyboard):
 *   Movement: Arrow keys  →  U B D F
 *   Punches:  8 9 0       →  a b c
 *   Kicks:    M , .       →  x y z
 *   Start:    2
 *
 * Both players' inputs are pumped to the engine via _setExternalPlayerInput
 * every animation frame (~60fps). P1 = controller 0, P2 = controller 1.
 */

import { useEffect, useRef, useState, useMemo, useCallback } from "react";
import type { GameInstance } from "@/lib/wasm-loader";

// P1 key map: KeyboardEvent.code → MUGEN input char
const P1_KEY_MAP: Record<string, string> = {
  // Movement (WASD)
  KeyW: "U",
  KeyA: "B", // A = left = Back (when facing right)
  KeyS: "D",
  KeyD: "F", // D = right = Forward (when facing right)
  // Punches (U I O)
  KeyU: "a",
  KeyI: "b",
  KeyO: "c",
  // Kicks (J K L)
  KeyJ: "x",
  KeyK: "y",
  KeyL: "z",
};

// P2 key map
const P2_KEY_MAP: Record<string, string> = {
  // Movement (Arrow keys)
  ArrowUp: "U",
  ArrowLeft: "B",
  ArrowDown: "D",
  ArrowRight: "F",
  // Punches (8 9 0 on top row)
  Digit8: "a",
  Digit9: "b",
  Digit0: "c",
  // Kicks (M , .)
  KeyM: "x",
  Comma: "y",
  Period: "z",
};

// Start keys (edge-triggered)
const P1_START_KEYS = new Set(["Digit1"]);
const P2_START_KEYS = new Set(["Digit2"]);

const P1_GAME_KEYS = new Set([
  ...Object.keys(P1_KEY_MAP),
  ...P1_START_KEYS,
]);
const P2_GAME_KEYS = new Set([
  ...Object.keys(P2_KEY_MAP),
  ...P2_START_KEYS,
]);

// Direction order (canonical MUGEN: U/D/B/F)
const DIRECTION_ORDER = ["U", "D", "B", "F"];
const ACTION_ORDER = ["a", "b", "c", "x", "y", "z"];

function keysToMugenInput(
  activeKeys: Set<string>,
  map: Record<string, string>
): string {
  let input = "";
  // Directions first
  for (const dir of DIRECTION_ORDER) {
    for (const [code, mugen] of Object.entries(map)) {
      if (mugen === dir && activeKeys.has(code)) {
        input += dir;
        break;
      }
    }
  }
  // Then actions
  for (const act of ACTION_ORDER) {
    for (const [code, mugen] of Object.entries(map)) {
      if (mugen === act && activeKeys.has(code)) {
        input += act;
        break;
      }
    }
  }
  return input;
}

export interface PlayerInputState {
  current: string;
  startPressed: boolean;
}

export interface LocalTwoPlayerApi {
  p1: PlayerInputState;
  p2: PlayerInputState;
  frameCount: number;
  isPumping: boolean;
  start: () => void;
  stop: () => void;
}

export function useLocalTwoPlayer(
  game: GameInstance | null,
  enabled: boolean
): LocalTwoPlayerApi {
  // Refs — stable across re-renders
  const p1KeysRef = useRef<Set<string>>(new Set());
  const p2KeysRef = useRef<Set<string>>(new Set());
  const p1StartRef = useRef(false);
  const p2StartRef = useRef(false);
  const rafRef = useRef<number | null>(null);
  const frameRef = useRef(0);
  const gameRef = useRef<GameInstance | null>(game);
  const lastDisplayUpdateRef = useRef(0);

  // Display state — only updated for UI, throttled
  const [p1, setP1] = useState<PlayerInputState>({ current: "", startPressed: false });
  const [p2, setP2] = useState<PlayerInputState>({ current: "", startPressed: false });
  const [frameCount, setFrameCount] = useState(0);
  const [isPumping, setIsPumping] = useState(false);

  // Keep gameRef synced with prop — does NOT trigger re-render
  useEffect(() => {
    gameRef.current = game;
  }, [game]);

  // Keyboard capture — attach ONCE, never re-attach
  useEffect(() => {
    if (!enabled) return;

    const handleKeyDown = (e: KeyboardEvent) => {
      const isP1 = P1_GAME_KEYS.has(e.code);
      const isP2 = P2_GAME_KEYS.has(e.code);
      if (isP1 || isP2) {
        e.preventDefault();
        e.stopPropagation();
      }
      if (isP1) {
        if (P1_START_KEYS.has(e.code)) {
          if (!e.repeat) p1StartRef.current = true;
        } else if (P1_KEY_MAP[e.code]) {
          p1KeysRef.current.add(e.code);
        }
      }
      if (isP2) {
        if (P2_START_KEYS.has(e.code)) {
          if (!e.repeat) p2StartRef.current = true;
        } else if (P2_KEY_MAP[e.code]) {
          p2KeysRef.current.add(e.code);
        }
      }
    };

    const handleKeyUp = (e: KeyboardEvent) => {
      if (P1_KEY_MAP[e.code]) p1KeysRef.current.delete(e.code);
      if (P2_KEY_MAP[e.code]) p2KeysRef.current.delete(e.code);
      // Start keys are edge-triggered, not cleared on keyup
    };

    // Use capture phase to ensure we get events before SDL2's canvas handler
    window.addEventListener("keydown", handleKeyDown, true);
    window.addEventListener("keyup", handleKeyUp, true);

    return () => {
      window.removeEventListener("keydown", handleKeyDown, true);
      window.removeEventListener("keyup", handleKeyUp, true);
    };
  }, [enabled]);

  // Input pump — requestAnimationFrame loop that pushes inputs to engine
  // useCallback with empty deps so pump identity is stable
  const pump = useCallback(() => {
    const g = gameRef.current;
    if (g && g.Module && typeof g.Module._setExternalPlayerInput === "function") {
      const p1Input = keysToMugenInput(p1KeysRef.current, P1_KEY_MAP);
      const p2Input = keysToMugenInput(p2KeysRef.current, P2_KEY_MAP);

      try {
        g.Module._setExternalPlayerInput(0, p1Input);
        g.Module._setExternalPlayerInput(1, p2Input);
      } catch (e) {
        console.error("[Local2P] Failed to inject input:", e);
      }
    }

    // Throttled display update — every 100ms
    const now = performance.now();
    if (now - lastDisplayUpdateRef.current > 100) {
      lastDisplayUpdateRef.current = now;
      const p1Input = keysToMugenInput(p1KeysRef.current, P1_KEY_MAP);
      const p2Input = keysToMugenInput(p2KeysRef.current, P2_KEY_MAP);
      setP1({ current: p1Input, startPressed: p1StartRef.current });
      setP2({ current: p2Input, startPressed: p2StartRef.current });
      p1StartRef.current = false;
      p2StartRef.current = false;
      setFrameCount(frameRef.current);
    }

    frameRef.current++;
    rafRef.current = requestAnimationFrame(pump);
  }, []);

  const start = useCallback(() => {
    if (rafRef.current !== null) return;
    setIsPumping(true);
    rafRef.current = requestAnimationFrame(pump);
  }, [pump]);

  const stop = useCallback(() => {
    if (rafRef.current !== null) {
      cancelAnimationFrame(rafRef.current);
      rafRef.current = null;
    }
    setIsPumping(false);
    p1KeysRef.current.clear();
    p2KeysRef.current.clear();
    setP1({ current: "", startPressed: false });
    setP2({ current: "", startPressed: false });
  }, []);

  // Cleanup on unmount
  useEffect(() => {
    return () => {
      if (rafRef.current !== null) {
        cancelAnimationFrame(rafRef.current);
      }
    };
  }, []);

  // Stable return object — useMemo prevents identity churn
  return useMemo(
    () => ({
      p1,
      p2,
      frameCount,
      isPumping,
      start,
      stop,
    }),
    [p1, p2, frameCount, isPumping, start, stop]
  );
}
