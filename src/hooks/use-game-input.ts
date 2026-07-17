"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { keyboardToInputString } from "@/lib/wasm-loader";

/**
 * React hook that tracks currently pressed keys and converts them
 * to MUGEN input strings. Supports subscription pattern so
 * multiple consumers (local play + relay) can react to inputs.
 */

type InputSubscriber = (input: string, frame: number) => void;

export function useGameInput() {
  const activeKeysRef = useRef<Set<string>>(new Set());
  const subscribersRef = useRef<Set<InputSubscriber>>(new Set());
  const frameRef = useRef(0);
  const [lastInput, setLastInput] = useState("");

  const subscribe = useCallback((fn: InputSubscriber) => {
    subscribersRef.current.add(fn);
    return () => {
      subscribersRef.current.delete(fn);
    };
  }, []);

  const getCurrentInput = useCallback((): string => {
    return keyboardToInputString(activeKeysRef.current);
  }, []);

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Prevent default for game keys (arrows, etc.)
      if (
        e.code.startsWith("Arrow") ||
        ["KeyZ", "KeyX", "KeyC", "KeyA", "KeyS", "KeyD", "KeyQ", "Enter"].includes(
          e.code
        )
      ) {
        e.preventDefault();
      }
      activeKeysRef.current.add(e.code);
      const input = keyboardToInputString(activeKeysRef.current);
      setLastInput(input);
      // Notify subscribers
      subscribersRef.current.forEach((fn) => fn(input, frameRef.current));
    };

    const handleKeyUp = (e: KeyboardEvent) => {
      activeKeysRef.current.delete(e.code);
      const input = keyboardToInputString(activeKeysRef.current);
      setLastInput(input);
      subscribersRef.current.forEach((fn) => fn(input, frameRef.current));
    };

    window.addEventListener("keydown", handleKeyDown);
    window.addEventListener("keyup", handleKeyUp);

    return () => {
      window.removeEventListener("keydown", handleKeyDown);
      window.removeEventListener("keyup", handleKeyUp);
    };
  }, []);

  return {
    /** Current MUGEN input string (reactive) */
    lastInput,
    /** Get current input without subscribing */
    getCurrentInput,
    /** Subscribe to input changes. Returns unsubscribe function. */
    subscribe,
    /** Advance the frame counter (call each engine tick) */
    advanceFrame: () => {
      frameRef.current++;
    },
    /** Reset frame counter */
    resetFrame: () => {
      frameRef.current = 0;
    },
  };
}