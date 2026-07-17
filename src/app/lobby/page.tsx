"use client";

import Link from "next/link";
import { useState } from "react";

/**
 * Lobby page — main entry point.
 *
 * Shows three options:
 *   1. Local 2P — two players share one keyboard (Phase 1)
 *   2. Create Room — start an online match (Phase 1.5)
 *   3. Join Room — join an existing online match by code (Phase 1.5)
 *
 * Online options are disabled in Phase 1 since the relay server
 * doesn't exist yet.
 */

export default function LobbyPage() {
  const [joinCode, setJoinCode] = useState("");

  return (
    <main className="lobby">
      <div className="lobby__card">
        <h1 className="lobby__title">FIGHTING GAME ENGINE</h1>
        <p className="lobby__subtitle">
          Browser-based 2D fighting game · MUGEN + WebAssembly
        </p>

        <div className="lobby__section">
          <h2 className="lobby__heading">Play Locally</h2>
          <Link href="/local" className="btn btn--primary btn--large">
            Local 2P (same keyboard)
          </Link>
          <p className="lobby__hint">
            Two players, one keyboard. P1 uses WASD+UIO, P2 uses arrows+890.
          </p>
        </div>

        <div className="lobby__section lobby__section--disabled">
          <h2 className="lobby__heading">Play Online (Phase 1.5)</h2>
          <button className="btn btn--disabled" disabled>
            Create Room
          </button>
          <div className="lobby__join">
            <input
              type="text"
              className="lobby__input"
              placeholder="ROOM CODE"
              maxLength={6}
              value={joinCode}
              onChange={(e) => setJoinCode(e.target.value.toUpperCase())}
              disabled
            />
            <button className="btn btn--disabled" disabled>
              Join
            </button>
          </div>
          <p className="lobby__hint lobby__hint--muted">
            Online relay comes in Phase 1.5 (rollback netcode).
          </p>
        </div>

        <div className="lobby__section lobby__section--links">
          <a href="/test/input-bridge.html" className="lobby__link">
            Phase 0.5 Input Bridge Test
          </a>
          <span className="lobby__version">Phase 1 · v0.1.0</span>
        </div>
      </div>
    </main>
  );
}
