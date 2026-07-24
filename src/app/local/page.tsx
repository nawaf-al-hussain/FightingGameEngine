"use client";

import { useState, useCallback, useEffect } from "react";
import dynamic from "next/dynamic";
import CharacterSelect from "@/components/CharacterSelect";
import { useLocalTwoPlayer } from "@/hooks/use-local-two-player";
import type { CharacterInfo } from "@/lib/character-catalog";
import type { GameInstance } from "@/lib/wasm-loader";

// GameCanvas is dynamically loaded because it touches `window` (Emscripten)
// and must only render client-side.
const GameCanvas = dynamic(() => import("@/components/GameCanvas"), {
  ssr: false,
  loading: () => <div className="game-loading"><p>Loading engine...</p></div>,
});

type Screen = "select" | "fight";

/**
 * Local 2P page — character select then local fight.
 *
 * Phase 1: Both players share one keyboard. After both lock in their
 * characters, the GameCanvas mounts and the input pump starts.
 */
export default function LocalPage() {
  const [screen, setScreen] = useState<Screen>("select");
  const [p1Char, setP1Char] = useState<CharacterInfo | null>(null);
  const [p2Char, setP2Char] = useState<CharacterInfo | null>(null);
  const [game, setGame] = useState<GameInstance | null>(null);

  const handleLockIn = useCallback((p1: CharacterInfo, p2: CharacterInfo) => {
    setP1Char(p1);
    setP2Char(p2);
    setScreen("fight");
  }, []);

  const handleCancel = useCallback(() => {
    window.location.href = "/lobby";
  }, []);

  const handleExitMatch = useCallback(() => {
    setScreen("select");
    setP1Char(null);
    setP2Char(null);
    setGame(null);
  }, []);

  if (screen === "select") {
    return (
      <main className="local-page">
        <CharacterSelect onLockIn={handleLockIn} onCancel={handleCancel} />
      </main>
    );
  }

  return (
    <main className="local-page local-page--fight">
      <FightScreen
        p1Char={p1Char!}
        p2Char={p2Char!}
        onGameReady={setGame}
        onExit={handleExitMatch}
        game={game}
      />
    </main>
  );
}

interface FightScreenProps {
  p1Char: CharacterInfo;
  p2Char: CharacterInfo;
  game: GameInstance | null;
  onGameReady: (g: GameInstance) => void;
  onExit: () => void;
}

function FightScreen({ p1Char, p2Char, game, onGameReady, onExit }: FightScreenProps) {
  const twoPlayer = useLocalTwoPlayer(game, true);

  // Auto-start the input pump when game becomes available
  useEffect(() => {
    if (game && !twoPlayer.isPumping) {
      twoPlayer.start();
    }
  }, [game, twoPlayer]);

  // Exit on Escape
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (e.code === "Escape" && !e.repeat) {
        e.preventDefault();
        onExit();
      }
    };
    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [onExit]);

  return (
    <div className="fight">
      <div className="fight__hud">
        <div className="fight__player fight__player--p1">
          <div className="fight__player-name">P1: {p1Char.displayName}</div>
          <div className="fight__player-input">Input: <code>{twoPlayer.p1.current || "—"}</code></div>
        </div>
        <div className="fight__center">
          <div className="fight__vs">VS</div>
          <div className="fight__frame">Frame: {twoPlayer.frameCount}</div>
          <button onClick={onExit} className="btn btn--secondary btn--small">
            Exit (Esc)
          </button>
        </div>
        <div className="fight__player fight__player--p2">
          <div className="fight__player-name">P2: {p2Char.displayName}</div>
          <div className="fight__player-input">Input: <code>{twoPlayer.p2.current || "—"}</code></div>
        </div>
      </div>

      <div className="fight__canvas-wrap">
        <GameCanvas onReady={onGameReady} p1Char={p1Char.id} p2Char={p2Char.id} />
      </div>

      <div className="fight__controls-help">
        <div><strong>P1:</strong> WASD = move, U/I/O = punch, J/K/L = kick, 1 = start</div>
        <div><strong>P2:</strong> Arrows = move, 8/9/0 = punch, M/,/. = kick, 2 = start</div>
      </div>
    </div>
  );
}
