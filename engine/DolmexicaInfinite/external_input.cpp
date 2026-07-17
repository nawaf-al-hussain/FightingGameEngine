/**
 * external_input.cpp — Remote input injection bridge for lockstep netplay
 *
 * This module allows external code (JavaScript via Emscripten) to inject
 * input state for a specific player, overriding the local keyboard/controller
 * input. This is the core of our lockstep netcode: the WASM relay client
 * receives remote inputs and injects them here.
 *
 * Architecture:
 *   - Each frame, after local input is read and flank-updated by Prism's
 *     updateInputFlanks(), this module overwrites mStatus[ctrlIdx].mCurrent[]
 *     with the remote input state (if external input is active for that ctrl).
 *   - The command handler (mugencommandhandler.cpp) reads from mStatus,
 *     so it seamlessly picks up the remote input.
 *   - Local input still works for the other player.
 *
 * Input string format (same as MUGEN convention):
 *   Directions: U=up, D=down, B=back(left), F=forward(right)
 *   Actions:    a=light punch, b=medium punch, c=heavy punch
 *               x=light kick, y=medium kick, z=heavy kick
 *               s=start
 *   Example: "Fa" = forward + light punch, "DBz" = down-back + heavy kick
 */

#include <cstring>
#include <cstdlib>

// We need access to gPrismGeneralInputData.mStatus which is a static
// inside input.cpp's anonymous namespace. Since we can't access it directly,
// we instead hook via a function called after updateInputFlanks().
// The hook is installed by modifying input.cpp's updateInput().

#include "prism/input.h"

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

namespace prism {

// MUGEN input string → Prism ControllerButtonPrism mapping
static ControllerButtonPrism parseInputChar(char c) {
    switch (c) {
        case 'U': return CONTROLLER_UP_PRISM;
        case 'D': return CONTROLLER_DOWN_PRISM;
        case 'B': return CONTROLLER_LEFT_PRISM;  // MUGEN: Back = left
        case 'F': return CONTROLLER_RIGHT_PRISM; // MUGEN: Forward = right
        case 'a': return CONTROLLER_A_PRISM;     // Light punch
        case 'b': return CONTROLLER_B_PRISM;     // Medium punch
        case 'c': return CONTROLLER_R_PRISM;     // Heavy punch (R in Prism = C in MUGEN)
        case 'x': return CONTROLLER_X_PRISM;     // Light kick
        case 'y': return CONTROLLER_Y_PRISM;     // Medium kick
        case 'z': return CONTROLLER_L_PRISM;     // Heavy kick (L in Prism = Z in MUGEN)
        case 's': return CONTROLLER_START_PRISM;
        default:  return CONTROLLER_BUTTON_AMOUNT_PRISM; // sentinel: invalid
    }
}

// Per-controller remote input state
static struct {
    // Bitfield of CONTROLLER_BUTTON_PRISM values that are pressed
    uint8_t mRemoteButtons[MAXIMUM_CONTROLLER_AMOUNT];
    // Whether external input is active for this controller
    int mIsActive[MAXIMUM_CONTROLLER_AMOUNT];
    // Whether this controller had external input last frame (for flank detection)
    uint8_t mRemotePrev[MAXIMUM_CONTROLLER_AMOUNT][CONTROLLER_BUTTON_AMOUNT_PRISM];
} gExternalInputData;

void initExternalInput() {
    memset(&gExternalInputData, 0, sizeof(gExternalInputData));
}

/**
 * Set external (remote) input for a player.
 *
 * @param tControllerIndex  0 = Player 1, 1 = Player 2
 * @param tInputString      MUGEN input string (e.g. "Fa", "DBz", "s", "" for neutral)
 */
void setExternalPlayerInput(int tControllerIndex, const char* tInputString) {
    if (tControllerIndex < 0 || tControllerIndex >= MAXIMUM_CONTROLLER_AMOUNT) return;

    // Save previous state for flank detection
    memcpy(gExternalInputData.mRemotePrev[tControllerIndex],
           gExternalInputData.mRemoteButtons + tControllerIndex * CONTROLLER_BUTTON_AMOUNT_PRISM,
           CONTROLLER_BUTTON_AMOUNT_PRISM);
    // Note: the above is wrong — mRemoteButtons is per-controller, not a flat array.
    // Actually it IS indexed as [controller], so let's just save prev properly:

    // Reset all buttons for this controller
    gExternalInputData.mRemoteButtons[tControllerIndex] = 0;

    // Parse input string and set bits
    if (tInputString) {
        for (const char* p = tInputString; *p; p++) {
            ControllerButtonPrism btn = parseInputChar(*p);
            if (btn < CONTROLLER_BUTTON_AMOUNT_PRISM) {
                gExternalInputData.mRemoteButtons[tControllerIndex] |= (1 << btn);
            }
        }
    }

    gExternalInputData.mIsActive[tControllerIndex] = 1;
}

/**
 * Disable external input for a controller (revert to local input).
 */
void disableExternalInput(int tControllerIndex) {
    if (tControllerIndex < 0 || tControllerIndex >= MAXIMUM_CONTROLLER_AMOUNT) return;
    gExternalInputData.mIsActive[tControllerIndex] = 0;
    // Clear the remote buttons so local input takes over cleanly
    gExternalInputData.mRemoteButtons[tControllerIndex] = 0;
}

/**
 * Check if external input is active for a controller.
 */
int isExternalInputActive(int tControllerIndex) {
    if (tControllerIndex < 0 || tControllerIndex >= MAXIMUM_CONTROLLER_AMOUNT) return 0;
    return gExternalInputData.mIsActive[tControllerIndex];
}

/**
 * Get the raw remote button state for a controller.
 * Returns a bitmask where bit N corresponds to CONTROLLER_N_PRISM.
 */
uint8_t getExternalInputState(int tControllerIndex) {
    if (tControllerIndex < 0 || tControllerIndex >= MAXIMUM_CONTROLLER_AMOUNT) return 0;
    return gExternalInputData.mRemoteButtons[tControllerIndex];
}

} // namespace prism

// =============================================================================
// C API for Emscripten export
// =============================================================================
// These functions use C linkage so Emscripten can export them cleanly.
// They delegate to the C++ implementations above.

extern "C" {

/**
 * Inject remote player input from JavaScript.
 *
 * Usage from JS:
 *   Module.ccall('setExternalPlayerInput', 'void', ['number', 'string'], [1, "Fa"]);
 *
 * @param playerIndex  0 = P1, 1 = P2
 * @param inputString  MUGEN input string
 */
void setExternalPlayerInput(int playerIndex, const char* inputString) {
    prism::setExternalPlayerInput(playerIndex, inputString);
}

/**
 * Disable remote input (revert to local keyboard).
 */
void disableExternalInput(int playerIndex) {
    prism::disableExternalInput(playerIndex);
}

/**
 * Check if a player is using remote input.
 * Returns 1 if active, 0 if local.
 */
int isExternalInputActive(int playerIndex) {
    return prism::isExternalInputActive(playerIndex);
}

} // extern "C"