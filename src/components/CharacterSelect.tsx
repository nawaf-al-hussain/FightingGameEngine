"use client";

/**
 * CharacterSelect — grid of bundled characters, each player picks one.
 *
 * In Phase 1 local 2P mode, both players share one keyboard:
 *   - P1 navigates with WASD + U (select)
 *   - P2 navigates with arrow keys + 0 (select)
 *
 * Click to select is also supported for testing on desktop.
 */

import { useState, useEffect, useCallback } from "react";
import {
  getPlayableCharacters,
  type CharacterInfo,
} from "@/lib/character-catalog";

interface CharacterSelectProps {
  onLockIn: (p1: CharacterInfo, p2: CharacterInfo) => void;
  onCancel: () => void;
}

export default function CharacterSelect({ onLockIn, onCancel }: CharacterSelectProps) {
  const characters = getPlayableCharacters();
  const [p1Index, setP1Index] = useState(0);
  const [p2Index, setP2Index] = useState(characters.length > 1 ? 1 : 0);
  const [p1Locked, setP1Locked] = useState(false);
  const [p2Locked, setP2Locked] = useState(false);

  // Keyboard navigation
  const handleKey = useCallback(
    (e: KeyboardEvent) => {
      // P1 navigation: WASD
      if (!p1Locked) {
        if (e.code === "KeyA" || e.code === "ArrowLeft") {
          // Only handle A for P1; arrows go to P2
          if (e.code === "KeyA") {
            e.preventDefault();
            setP1Index((i) => (i - 1 + characters.length) % characters.length);
          }
        }
        if (e.code === "KeyD") {
          e.preventDefault();
          setP1Index((i) => (i + 1) % characters.length);
        }
        if (e.code === "KeyW") {
          e.preventDefault();
          setP1Index((i) => (i - 2 + characters.length) % characters.length);
        }
        if (e.code === "KeyS") {
          e.preventDefault();
          setP1Index((i) => (i + 2) % characters.length);
        }
        // P1 select: U key
        if (e.code === "KeyU" && !e.repeat) {
          e.preventDefault();
          setP1Locked(true);
        }
      } else if (e.code === "KeyU" && !e.repeat) {
        // Allow P1 to un-lock by pressing U again
        e.preventDefault();
        setP1Locked(false);
      }

      // P2 navigation: Arrow keys
      if (!p2Locked) {
        if (e.code === "ArrowLeft") {
          e.preventDefault();
          setP2Index((i) => (i - 1 + characters.length) % characters.length);
        }
        if (e.code === "ArrowRight") {
          e.preventDefault();
          setP2Index((i) => (i + 1) % characters.length);
        }
        if (e.code === "ArrowUp") {
          e.preventDefault();
          setP2Index((i) => (i - 2 + characters.length) % characters.length);
        }
        if (e.code === "ArrowDown") {
          e.preventDefault();
          setP2Index((i) => (i + 2) % characters.length);
        }
        // P2 select: 0 key
        if (e.code === "Digit0" && !e.repeat) {
          e.preventDefault();
          setP2Locked(true);
        }
      } else if (e.code === "Digit0" && !e.repeat) {
        e.preventDefault();
        setP2Locked(false);
      }

      // Both locked → start match (any key triggers)
      if (p1Locked && p2Locked && (e.code === "KeyU" || e.code === "Digit0" || e.code === "Enter") && !e.repeat) {
        e.preventDefault();
        onLockIn(characters[p1Index], characters[p2Index]);
      }

      // Cancel
      if (e.code === "Escape") {
        e.preventDefault();
        onCancel();
      }
    },
    [p1Locked, p2Locked, characters, p1Index, p2Index, onLockIn, onCancel]
  );

  useEffect(() => {
    window.addEventListener("keydown", handleKey);
    return () => window.removeEventListener("keydown", handleKey);
  }, [handleKey]);

  return (
    <div className="char-select">
      <h1 className="char-select__title">SELECT YOUR CHARACTER</h1>
      <div className="char-select__grid">
        {characters.map((char, i) => {
          const isP1Here = i === p1Index;
          const isP2Here = i === p2Index;
          return (
            <button
              key={char.id}
              className={`char-card ${isP1Here ? "char-card--p1" : ""} ${isP2Here ? "char-card--p2" : ""} ${isP1Here && isP2Here ? "char-card--both" : ""}`}
              onClick={() => {
                // Click selects P1's character (desktop testing convenience)
                setP1Index(i);
                setP1Locked(true);
              }}
            >
              <div className="char-card__name">{char.displayName}</div>
              <div className="char-card__author">by {char.author}</div>
              <div className="char-card__desc">{char.description}</div>
              <div className="char-card__indicators">
                {isP1Here && <span className="char-indicator char-indicator--p1">P1{p1Locked ? " ✓" : ""}</span>}
                {isP2Here && <span className="char-indicator char-indicator--p2">P2{p2Locked ? " ✓" : ""}</span>}
              </div>
            </button>
          );
        })}
      </div>
      <div className="char-select__status">
        <div className={`char-status ${p1Locked ? "char-status--locked" : ""}`}>
          <strong>P1</strong>: {characters[p1Index].displayName} {p1Locked ? "✓ LOCKED" : "(press U to lock)"}
        </div>
        <div className={`char-status ${p2Locked ? "char-status--locked" : ""}`}>
          <strong>P2</strong>: {characters[p2Index].displayName} {p2Locked ? "✓ LOCKED" : "(press 0 to lock)"}
        </div>
      </div>
      <div className="char-select__controls">
        <div>
          <strong>P1 controls:</strong> WASD to navigate, U to lock in
        </div>
        <div>
          <strong>P2 controls:</strong> Arrow keys to navigate, 0 to lock in
        </div>
        <div>
          <button onClick={onCancel} className="btn btn--secondary">
            Cancel (Esc)
          </button>
          {(p1Locked && p2Locked) && (
            <button
              onClick={() => onLockIn(characters[p1Index], characters[p2Index])}
              className="btn btn--primary"
            >
              Start Match (U or 0)
            </button>
          )}
        </div>
      </div>
    </div>
  );
}
