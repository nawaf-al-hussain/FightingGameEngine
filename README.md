# Fighting Game Engine

Browser-based 2D fighting game platform using **Dolmexica Infinite** (MUGEN interpreter) compiled to WebAssembly, with Next.js frontend and Deno Deploy WebSocket relay.

## Architecture

```
┌─────────────┐     WebSocket      ┌──────────────┐
│  Player A   │◄──────────────────►│  Deno Relay  │
│  (Browser)  │                    │  (lockstep)  │
│  WASM+Next  │                    └──────┬───────┘
└─────────────┘                           │
                                    ┌─────▼──────┐
┌─────────────┐     WebSocket      │  Neon DB    │
│  Player B   │◄──────────────────►│  (Postgres) │
│  (Browser)  │                    └────────────┘
│  WASM+Next  │
└─────────────┘
```

## Tech Stack

| Layer | Technology | Cost |
|-------|-----------|------|
| Frontend | Next.js 14 + React 18 | Free (Vercel) |
| Game Engine | Dolmexica Infinite → WASM (Emscripten 6.0.3) | Free |
| WebSocket Relay | Deno Deploy | Free |
| Database | Neon Serverless Postgres | Free tier |
| Cache | Upstash Redis | Free tier |
| Asset Storage | Cloudflare R2 | Free 10GB |
| Audio | SDL_mixer (compiled into WASM) | Free |

## Project Structure

```
├── engine/DolmexicaInfinite/   # C++ MUGEN engine + Prism framework
│   └── chars/                  # MUGEN character assets
├── server/                     # Deno relay server
│   ├── src/ws/room-manager.ts  # Lockstep room & input logic
│   ├── db/queries.ts           # Database operations (stubs)
│   ├── db/migrations/          # PostgreSQL schema
│   └── utils/helpers.ts        # Session ID, room code generation
├── src/                        # Next.js frontend
│   ├── app/                    # App Router pages
│   ├── components/             # GameCanvas, TouchControls
│   ├── hooks/                  # useGameInput
│   ├── lib/                    # wasm-loader, relay-client
│   └── styles/                 # Game CSS
├── scripts/build-wasm.sh       # WASM build pipeline
├── tools/validate-mugen.py     # MUGEN asset validator
├── docs/                       # Design specs & deep-dives
└── public/game/                # WASM build output (gitignored)
```

## Quick Start

### Prerequisites
- Node.js 18+
- Emscripten SDK 6.0.3+
- Python 3 (for asset validator)

### Build Game Engine to WASM
```bash
# Activate Emscripten
source /path/to/emsdk_env.sh

# Build (requires engine source)
npm run build:wasm
```

### Run Frontend
```bash
npm install
npm run dev
```

### Validate Character Assets
```bash
python3 tools/validate-mugen.py engine/DolmexicaInfinite/chars/KnightmareSuperman/KnightmareSuperman.def
```

## Included Characters

| Character | Size | Source |
|-----------|------|--------|
| Knightmare Superman | ~69 MB | tmpfiles.org |
| Nightwing (O Illusionista) | ~30 MB | tmpfiles.org |
| Songoku | ~4 MB | bundled with engine |

## Key Technical Details

- **Lockstep netcode**: Both players run local WASM instances; relay only forwards inputs
- **FMOD replacement**: Proprietary FMOD audio replaced with open-source SDL_mixer (web/ implementations)
- **Mobile support**: Virtual D-pad + 5 action buttons with multi-touch
- **Emscripten 6.0.3**: Uses `--use-port=sdl2_image:formats=png` (not the old `-s SDL2_IMAGE_FORMATS` flag)

## License

See individual licenses for Dolmexica Infinite and included character assets.