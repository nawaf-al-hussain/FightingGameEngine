/**
 * external_input.h — Remote input injection for lockstep netplay
 *
 * Allows JavaScript (via Emscripten) to inject input for a remote player,
 * overriding the local keyboard/controller input for that player slot.
 */

#ifndef EXTERNAL_INPUT_H
#define EXTERNAL_INPUT_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Inject remote player input from JavaScript.
 *
 * Called each frame with the remote player's input state.
 * The input string uses MUGEN conventions:
 *   Directions: U (up), D (down), B (back/left), F (forward/right)
 *   Actions:    a (light punch), b (med punch), c (heavy punch)
 *               x (light kick), y (med kick), z (heavy kick)
 *               s (start)
 *   Empty string "" = no input (neutral)
 *
 * @param playerIndex  0 = Player 1, 1 = Player 2
 * @param inputString  Null-terminated MUGEN input string
 *
 * JS usage: Module.ccall('setExternalPlayerInput', 'void', ['number', 'string'], [1, "Fa"]);
 */
void setExternalPlayerInput(int playerIndex, const char* inputString);

/**
 * Disable remote input for a player, reverting to local keyboard.
 */
void disableExternalInput(int playerIndex);

/**
 * Check if a player is using remote input. Returns 1 if active.
 */
int isExternalInputActive(int playerIndex);

#ifdef __cplusplus
}
#endif

#endif /* EXTERNAL_INPUT_H */