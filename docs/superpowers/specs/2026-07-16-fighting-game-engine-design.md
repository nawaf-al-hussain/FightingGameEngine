# Fighting Game Engine — Design Spec

**Date:** 2026-07-16
**Status:** Draft
**Author:** Super Z + nawaf-al-hussain

## 1. Overview

Browser-based 2D fighting game platform using Dolmexica Infinite (MUGEN interpreter) compiled to WebAssembly. Players select characters, create/join rooms, and fight each other in real-time via lockstep netcode relayed through a WebSocket server.

Target region: Bangladesh. Target cost: $0 (no credit card).

## 2. Goals

- Run MUGEN-compatible fighting games in the browser via WASM
- Support real-time 1v1 online multiplayer with lockstep synchronization
- Mobile-friendly with virtual touch controls
- Deploy on free-tier services (Vercel, Deno Deploy, Neon DB, Cloudflare R2)

## 3. Non-Goals

- Building a new fighting game engine from scratch (we use Dolmexica Infinite)
- Single-player story mode or AI opponents (Phase 1+)
- Account systems beyond anonymous session IDs (Phase 1+)
- Spectator mode or replays (Phase 2+)

## 4. Architecture

```
┌─────────────┐     WebSocket      ┌──────────────┐
│  Player A   │◄──────────────────►│  Deno Relay  │
│  (Browser)  │                    │  (WebSocket) │
│  WASM+Next  │                    └──────┬───────┘
└─────────────┘                           │
                                    ┌─────▼──────┐
┌─────────────┐     WebSocket      │  Neon DB   │
│  Player B   │◄──────────────────►│  (Postgres)│
│  (Browser)  │                    └────────────┘
│  WASM+Next  │
└─────────────┘

Each browser runs a local WASM instance of Dolmexica Infinite.
The relay only forwards inputs — no game state sync.
Lockstep: both instances advance frame-by-frame with the same inputs.
```

## 5. Tech Stack

| Layer | Technology | Cost |
|-------|-----------|------|
| Frontend | Next.js 14 + React 18 | Free (Vercel) |
| Game Engine | Dolmexica Infinite → WASM (Emscripten) | Free |
| WebSocket Relay | Deno Deploy | Free ($0) |
| Database | Neon Serverless Postgres | Free tier |
| Cache | Upstash Redis | Free tier |
| Asset Storage | Cloudflare R2 | Free 10GB |
| Audio | SDL_mixer (compiled into WASM) | Free |

## 6. Key Technical Decisions

### 6.1 Lockstep Netcode
Both players run identical WASM instances. The relay server receives inputs from each player, buffers them by frame number, and forwards to the opponent. Each instance only advances when it has inputs for both players for the current frame.

### 6.2 FMOD Replacement
Dolmexica Infinite uses proprietary FMOD for audio. We replace it with SDL_mixer (`sound_web.cpp`, `soundeffect_web.cpp`) since FMOD cannot be compiled to WASM without a commercial license.

### 6.3 Asset Delivery
MUGEN assets (characters, stages) are stored on Cloudflare R2. The Emscripten `file_packager` tool bundles selected assets into a `.data` file that the WASM module loads at startup. For the initial build, assets are included directly. Later, a lazy-loading system will fetch from R2 on demand.

### 6.4 Mobile Support
Virtual D-pad (U/D/B/F) + 5 action buttons (A/B/C/X/Y) rendered as HTML overlays. Multi-touch supported via `touchstart`/`touchmove`/`touchend` events.

## 7. Risks

| Risk | Mitigation |
|------|-----------|
| Dolmexica WASM performance on mobile | Profile early, reduce asset sizes, offer quality toggle |
| Lockstep desync from packet loss | Frame prediction with rollback (Phase 2), timeout detection |
| Large asset files (100MB+ chars) | Asset pipeline with compression, selective palette loading |
| tmpfiles.org / asset hosting takedown | Mirror to R2, validate all assets before bundling |
| Emscripten version compatibility | Pin to 6.0.3, test on Chrome/Firefox/Safari |

## 8. Scope

### Phase 0: Engine to WASM
- Compile Dolmexica Infinite to WASM with SDL2, SDL_mixer, SDL2_image (PNG), SDL_ttf
- Replace FMOD with SDL_mixer web implementations
- Bundle 3 test characters and verify they load

### Phase 0.5: Input Bridge
- Add `setExternalPlayerInput()` C function for remote input injection
- Expose to JavaScript via Emscripten `ccall`/`cwrap`

### Phase 1: Frontend + Relay MVP
- Next.js game page with canvas
- Keyboard + touch input capture
- Deno Deploy WebSocket relay with room management
- Basic room creation/joining flow

### Phase 2: Polish
- Neon DB for room history
- Character select screen
- Upstash Redis for room state caching
- Cloudflare R2 asset delivery

### Phase 3: Scale
- Spectator mode
- Replay recording
- Ranked matchmaking