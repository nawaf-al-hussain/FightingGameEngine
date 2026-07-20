// start_direct_match.cpp — Direct match start (bypasses title/select screens)
//
// Exposed as _startDirectMatch(p1Char, p2Char, stagePath) via Emscripten.
// Initializes the engine, sets player characters and stage, then starts
// the fight screen directly — skipping all text-dependent menu screens.

#include "config.h"
#include "playerdefinition.h"
#include "fightscreen.h"
#include "gamelogic.h"
#include "versusscreen.h"
#include "stage.h"

#include <prism/wrapper.h>
#include <prism/system.h>
#include <prism/log.h>
#include <prism/debug.h>
#include <prism/framerateselectscreen.h>
#include <prism/screeneffect.h>
#include <prism/mugenanimationhandler.h>
#include <prism/mugentexthandler.h>
#include <prism/clipboardhandler.h>

#include <string.h>
#include <stdio.h>

extern "C" {

static int gDirectMatchStarted = 0;

static void directMatchFightFinishedCB() {
    // Return to a simple state — in a real game this would go back to lobby
    logg("[DIRECT_MATCH] Fight finished.");
}

static void directMatchVersusScreenFinishedCB() {
    setGameModeVersus();
    startFightScreen(directMatchFightFinishedCB);
}

static void startDirectMatchInternal(const char* p1Char, const char* p2Char, const char* stagePath) {
    logg("[DIRECT_MATCH] Setting up match...");
    
    // Build full paths
    char p1Path[1024], p2Path[1024], stageFullPath[1024];
    const char* assetFolder = getDolmexicaAssetFolder().c_str();
    
    sprintf(p1Path, "%schars/%s/%s.def", assetFolder, p1Char, p1Char);
    sprintf(p2Path, "%schars/%s/%s.def", assetFolder, p2Char, p2Char);
    sprintf(stageFullPath, "%sstages/%s", assetFolder, stagePath);
    
    logg("[DIRECT_MATCH] P1 path:");
    logString(p1Path);
    logg("[DIRECT_MATCH] P2 path:");
    logString(p2Path);
    logg("[DIRECT_MATCH] Stage path:");
    logString(stageFullPath);
    
    // Set player definition paths
    setPlayerDefinitionPath(0, p1Path);
    setPlayerDefinitionPath(1, p2Path);
    
    // Set the stage
    setDreamStageMugenDefinition(stageFullPath, "");
    
    // Set versus mode (2 rounds, human vs human)
    setGameModeVersus();
    
    // Set up versus screen callback for rematches
    setVersusScreenNoMatchNumber();
    setVersusScreenFinishedCB(directMatchVersusScreenFinishedCB);
    
    logg("[DIRECT_MATCH] Match setup complete.");
}

// Called from JavaScript to initialize the engine and start a match directly.
// This bypasses all menu screens (title, character select, versus) that
// require text rendering, which doesn't work in the WASM build.
//
// Must be called instead of _main(). The caller should NOT call _main().
//
// Parameters:
//   p1Char: character directory name (e.g., "Songoku")
//   p2Char: character directory name (e.g., "Vegeta")
//   stagePath: stage file path relative to stages/ (e.g., "stage0.def")
void startDirectMatch(const char* p1Char, const char* p2Char, const char* stagePath) {
    if (gDirectMatchStarted) {
        logg("[DIRECT_MATCH] Already started, setting up new match...");
        startDirectMatchInternal(p1Char, p2Char, stagePath);
        return;
    }
    gDirectMatchStarted = 1;
    
    logg("[DIRECT_MATCH] Initializing engine...");
    
    // Same initialization as main() but without font loading and screen handling
    setDevelopMode();
    setMinimumLogType(LOG_TYPE_NORMAL);
    
    setGameName("FIGHTING GAME ENGINE");
    setScreenSize(320, 240);
    
    if (!isOnDreamcast()) {
        setMugenSpriteFileReaderSubTextureSplit(8, 1024);
    }
    
    initPrismWrapperWithMugenFlags();
    logg("[DIRECT_MATCH] Wrapper initialized.");
    
    loadMugenConfig();
    logg("[DIRECT_MATCH] Config loaded.");
    
    loadGlobalVariables(PrismSaveSlot::AMOUNT);
    
    // Skip setFont and loadMugenSystemFonts — they crash in WASM
    // The engine will run without text rendering
    
    logg("[DIRECT_MATCH] Check framerate");
    FramerateSelectReturnType framerateReturnType = selectFramerate();
    if (framerateReturnType == FRAMERATE_SCREEN_RETURN_ABORT) {
        logg("[DIRECT_MATCH] Framerate abort, exiting.");
        return;
    }
    
    setMemoryHandlerCompressionActive();
    initClipboardForGame();
    setScreenEffectZ(99);
    setMugenAnimationHandlerPixelCenter(Vector2D(0.0, 0.0));
    
    // Skip initDolmexicaDebug — not needed for web
    // Skip disableWrapperErrorRecovery — keep error recovery enabled
    
    logg("[DIRECT_MATCH] Engine initialized. Setting up match...");
    
    // Set up player chars, stage, and game mode
    startDirectMatchInternal(p1Char, p2Char, stagePath);
    
    // Start screen handling with the fight screen directly.
    // getDreamFightScreenForTesting() returns the Screen* for the fight screen.
    // loadFightScreen() will be called by loadScreen(), which loads players
    // and stage using the paths we just set.
    logg("[DIRECT_MATCH] Starting screen handling with fight screen...");
    startScreenHandling(getDreamFightScreenForTesting());
    
    logg("[DIRECT_MATCH] Done.");
}

} // extern "C"
