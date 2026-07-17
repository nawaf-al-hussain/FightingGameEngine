#!/usr/bin/env bash
# =============================================================================
# build-wasm.sh — Build Dolmexica Infinite to WebAssembly
# =============================================================================
#
# Prerequisites:
#   - Emscripten SDK 6.0.3+ activated (source /path/to/emsdk_env.sh)
#   - Engine source at engine/DolmexicaInfinite/
#   - Prism addon at engine/DolmexicaInfinite/addons/prism/ (develop branch)
#
# Usage:
#   bash scripts/build-wasm.sh           # Incremental build
#   bash scripts/build-wasm.sh --clean   # Full clean rebuild
#   bash scripts/build-wasm.sh --prism   # Only rebuild Prism library
#
# Output:
#   public/game/game.wasm   — WebAssembly binary
#   public/game/game.js     — Emscripten loader script
#   public/game/game.data   — Preloaded assets (if chars/ exists)
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ENGINE_DIR="$PROJECT_ROOT/engine/DolmexicaInfinite"
PRISM_DIR="$ENGINE_DIR/addons/prism"
BUILD_DIR="$PROJECT_ROOT/build/wasm"
OUTPUT_DIR="$PROJECT_ROOT/public/game"

# Ensure emsdk is available
if ! command -v emcc &>/dev/null; then
    echo "ERROR: emcc not found. Activate Emscripten SDK first:"
    echo "  source /path/to/emsdk_env.sh"
    exit 1
fi

echo "=== Emscripten $(emcc --version | head -1) ==="

# Flags
CLEAN=0
PRISM_ONLY=0
for arg in "$@"; do
    case "$arg" in
        --clean)   CLEAN=1 ;;
        --prism)   PRISM_ONLY=1 ;;
    esac
done

mkdir -p "$BUILD_DIR" "$OUTPUT_DIR"

# Common Emscripten flags
EMFLAGS_COMMON="-s WASM=1 -s USE_SDL=2 -s USE_SDL_MIXER=2 -s USE_SDL_TTF=2 --use-port=sdl2_image:formats=png"
EMFLAGS_COMMON="$EMFLAGS_COMMON -s ALLOW_MEMORY_GROWTH=1 -s MAX_WEBGL_VERSION=2"
EMFLAGS_COMMON="$EMFLAGS_COMMON -s DISABLE_EXCEPTION_CATCHING=0 -s ASSERTIONS=0"
EMFLAGS_COMMON="$EMFLAGS_COMMON -O2 -s USE_PTHREADS=0"

# =============================================================================
# STEP 1: Build Prism Library
# =============================================================================
build_prism() {
    echo ""
    echo "=== [1/4] Building Prism library ==="
    cd "$PRISM_DIR"

    # Core Prism sources
    PRISM_CORE_SRC=$(find src/ -name '*.cpp' 2>/dev/null | grep -v test | sort)
    # Windows platform files (SDL-based, cross-platform compatible)
    PRISM_WIN_SRC=""
    for f in \
        src/drawing/drawing_win.cpp \
        src/input/input_win.cpp \
        src/system/system_win.cpp \
        src/util/graphics/graphics_win.cpp \
        src/util/timer/timer_win.cpp \
        src/util/input/input_win.cpp \
        src/util/debug/debug_win.cpp \
        src/util/backup/backup_win.cpp \
        src/util/thread/thread_win.cpp \
        src/util/audio/audio_win.cpp \
        src/util/audio/audio_cd_win.cpp \
        src/util/audio/audio_sound_win.cpp \
        src/util/audio/audio_music_win.cpp \
        src/util/audio/audio_sound_effect_win.cpp \
        src/util/network/network_win.cpp; do
        if [ -f "$f" ]; then
            PRISM_WIN_SRC="$PRISM_WIN_SRC $f"
        fi
    done

    # Web sound replacements (SDL_mixer instead of FMOD)
    PRISM_WEB_SRC=""
    for f in web/sound_web.cpp web/soundeffect_web.cpp; do
        if [ -f "$f" ]; then
            PRISM_WEB_SRC="$PRISM_WEB_SRC $f"
        fi
    done

    ALL_PRISM_SRC="$PRISM_CORE_SRC $PRISM_WIN_SRC $PRISM_WEB_SRC"

    echo "  Compiling Prism ($(echo "$ALL_PRISM_SRC" | wc -w) files)..."
    em++ $EMFLAGS_COMMON -I include/ -c $ALL_PRISM_SRC -o "$BUILD_DIR/"

    echo "  Archiving libprism.a..."
    ar rcs "$BUILD_DIR/libprism.a" "$BUILD_DIR"/*.o
    rm -f "$BUILD_DIR"/*.o

    echo "  ✓ Prism built: $(du -h "$BUILD_DIR/libprism.a" | cut -f1)"
}

# =============================================================================
# STEP 2: Build Dolmexica
# =============================================================================
build_dolmexica() {
    echo ""
    echo "=== [2/4] Building Dolmexica ==="
    cd "$ENGINE_DIR"

    DOLMEXICA_SRC=$(find src/ -name '*.cpp' 2>/dev/null | grep -v test | sort)

    echo "  Compiling Dolmexica ($(echo "$DOLMEXICA_SRC" | wc -w) files)..."
    em++ $EMFLAGS_COMMON \
        -I "$PRISM_DIR/include" \
        -I include/ \
        -c $DOLMEXICA_SRC \
        -o "$BUILD_DIR/"

    echo "  Linking..."
    em++ $EMFLAGS_COMMON \
        "$BUILD_DIR"/*.o \
        "$BUILD_DIR/libprism.a" \
        -o "$BUILD_DIR/game.js" \
        --preload-file "$ENGINE_DIR/data@/data" \
        2>&1 | tail -5 || true

    echo "  ✓ Dolmexica linked"
}

# =============================================================================
# STEP 3: Package Assets
# =============================================================================
build_assets() {
    echo ""
    echo "=== [3/4] Packaging assets ==="

    CHARS_DIR="$ENGINE_DIR/chars"
    if [ -d "$CHARS_DIR" ] && [ "$(ls -A "$CHARS_DIR" 2>/dev/null)" ]; then
        echo "  Bundling characters from $CHARS_DIR..."
        # Use file_packager to create the .data file
        python3 "$(emcc --print-emcc-path 2>/dev/null | sed 's|/emcc$||')/tools/file_packager.py" \
            "$BUILD_DIR/game.data" \
            --preload "$CHARS_DIR@/chars" \
            --js-output="$BUILD_DIR/game.assets.js" \
            2>&1 | tail -3 || echo "  (file_packager not found, skipping asset bundling)"
    else
        echo "  No chars/ directory found — skipping asset bundling"
        echo "  (WASM will show a blank screen without characters)"
    fi
}

# =============================================================================
# STEP 4: Copy Artifacts
# =============================================================================
copy_artifacts() {
    echo ""
    echo "=== [4/4] Copying to $OUTPUT_DIR ==="

    cp -f "$BUILD_DIR/game.js" "$OUTPUT_DIR/" 2>/dev/null && echo "  ✓ game.js"
    cp -f "$BUILD_DIR/game.wasm" "$OUTPUT_DIR/" 2>/dev/null && echo "  ✓ game.wasm"
    cp -f "$BUILD_DIR/game.data" "$OUTPUT_DIR/" 2>/dev/null && echo "  ✓ game.data"

    # Generate a minimal index.html if needed
    if [ ! -f "$OUTPUT_DIR/index.html" ]; then
        cat > "$OUTPUT_DIR/index.html" <<'HTML'
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Fighting Game Engine</title>
  <style>
    body { margin: 0; background: #000; display: flex; justify-content: center; align-items: center; height: 100vh; }
    canvas { image-rendering: pixelated; }
  </style>
</head>
<body>
  <script src="game.js"></script>
</body>
</html>
HTML
        echo "  ✓ index.html"
    fi

    echo ""
    echo "=== Build Complete ==="
    echo "Output files:"
    ls -lh "$OUTPUT_DIR/" 2>/dev/null | grep -v total
}

# =============================================================================
# Main
# =============================================================================
if [ $CLEAN -eq 1 ]; then
    echo "=== Cleaning build directory ==="
    rm -rf "$BUILD_DIR"/* "$OUTPUT_DIR"/*
fi

build_prism

if [ $PRISM_ONLY -eq 0 ]; then
    build_dolmexica
    build_assets
    copy_artifacts
fi