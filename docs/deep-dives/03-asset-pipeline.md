# Asset Pipeline

## Pipeline Stages

### 1. Download
- Characters come from MUGEN archive sites (Mugen Archive, etc.)
- Formats: .zip, .rar
- Stored temporarily in `upload/` (gitignored)

### 2. Validate
- `tools/validate-mugen.py` checks:
  - `.def` file exists and is parseable
  - `.sff` header is valid (v1 or v2 magic bytes)
  - `.snd` file exists
  - No path traversal in filenames
  - Total size < 50MB

### 3. Stage to R2
- Validated characters uploaded to Cloudflare R2
- Path: `r2://mugen-assets/chars/{CharacterName}/`
- Public URL: `https://assets.fge.dev/chars/{CharacterName}/`

### 4. WASM Repackage
- Emscripten `file_packager` bundles selected assets into `game.data`
- Preload list built from room's character + stage selection
- `--preload` flag embeds files into the virtual filesystem

### 5. Deploy
- `game.data` + `game.wasm` + `game.js` deployed to Vercel
- For dynamic asset loading: fetch from R2, mount into Emscripten MEMFS at runtime

## Size Estimates

| Character | SFF | SND | CNS/AIR/CMD | Total |
|-----------|-----|-----|-------------|-------|
| Knightmare Superman | 41MB | 26MB | 1.5MB | ~69MB |
| Nightwing | 20MB | 9.5MB | 0.5MB | ~30MB |
| Songoku | 2MB | 2MB | 0.1MB | ~4MB |

The Knightmare Superman character alone is 69MB. We'll need to:
- Compress SFF/SND where possible
- Consider lazy-loading sprites on demand
- Or limit initial roster to smaller characters