/**
 * WASM Game Engine Loader
 *
 * Dynamically loads the Emscripten-compiled Dolmexica Infinite WASM module
 * and provides typed wrappers for engine functions.
 */

export interface GameInstance {
  /** Emscripten module — call cwrap/ccall on this */
  Module: {
    ccall: (
      name: string,
      returnType: string | null,
      argTypes: string[],
      args: unknown[]
    ) => unknown;
    cwrap: (
      name: string,
      returnType: string | null,
      argTypes: string[]
    ) => (...args: unknown[]) => unknown;
    _setExternalPlayerInput: (playerIndex: number, inputStr: string) => void;
    canvas: HTMLCanvasElement | null;
  };
}

/** Mapping from browser KeyboardEvent.code to MUGEN input characters.
 *  Note: Start (Q/Enter) is intentionally NOT in this map — it's an event,
 *  not a held state. See use-game-input.ts for Start handling (FIX-4). */
const KEY_MAP: Record<string, string> = {
  ArrowUp: "U",
  ArrowDown: "D",
  ArrowLeft: "B", // MUGEN: Back = left
  ArrowRight: "F", // MUGEN: Forward = right
  KeyZ: "a", // Light punch
  KeyX: "b", // Medium punch
  KeyC: "c", // Heavy punch
  KeyA: "x", // Light kick
  KeyS: "y", // Medium kick
  KeyD: "z", // Heavy kick
};

/** Key codes that trigger the MUGEN Start button (edge-triggered, not held) */
export const START_KEYS = ["KeyQ", "Enter"];

/**
 * Convert a set of pressed key codes to a MUGEN input string.
 * MUGEN expects characters like "U" (up), "D" (down), "a" (light punch), etc.
 * Multiple simultaneous inputs are concatenated: "Fa" = forward + light punch.
 *
 * Note: Start is NOT included — it's an edge-triggered event, not a held state (FIX-4).
 */
export function keyboardToInputString(activeKeys: Set<string>): string {
  let input = "";
  // Direction first (U/D/B/F), then actions (a/b/c/x/y/z)
  for (const key of ["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"]) {
    if (activeKeys.has(key)) {
      input += KEY_MAP[key];
    }
  }
  for (const key of ["KeyZ", "KeyX", "KeyC", "KeyA", "KeyS", "KeyD"]) {
    if (activeKeys.has(key)) {
      input += KEY_MAP[key];
    }
  }
  return input;
}

/**
 * Load the game engine WASM module.
 * FIX-2: Uses the Emscripten onRuntimeInitialized callback pattern instead
 * of a setTimeout-based race. Pre-configures window.Module with a callback
 * before loading game.js, so Emscripten uses our config when it boots.
 *
 * Usage: call this BEFORE dynamically loading game.js script tag.
 * Returns a Promise that resolves once the WASM runtime is fully initialized.
 */
export function loadGameEngine(): Promise<GameInstance> {
  return new Promise((resolve, reject) => {
    const timeout = setTimeout(() => {
      reject(new Error(
        "WASM runtime initialization timed out after 30 seconds. " +
        "Check console for errors."
      ));
    }, 30000);

    // Configure Module with onRuntimeInitialized callback BEFORE game.js loads.
    // Emscripten will pick up window.Module if it exists, then override these
    // fields with its own internals while preserving our callback.
    const w = window as unknown as Record<string, unknown>;
    const existingConfig = (w.Module as Record<string, unknown> | undefined) || {};

    w.Module = {
      ...existingConfig,
      onRuntimeInitialized: () => {
        clearTimeout(timeout);
        const module = w.Module as GameInstance["Module"];
        if (!module) {
          reject(new Error("Module not found after runtime init"));
          return;
        }
        resolve({ Module: module } as GameInstance);
      },
    };
  });
}

/** Inject a remote player's input into the WASM engine.
 * @param game The loaded GameInstance
 * @param controllerIndex 0 = Player 1, 1 = Player 2
 * @param inputString MUGEN input string (e.g. "Fa", "DBz", "")
 */
export function injectRemoteInput(
  game: GameInstance,
  controllerIndex: number, // 0 = P1, 1 = P2
  inputString: string
): void {
  if (game.Module._setExternalPlayerInput) {
    game.Module._setExternalPlayerInput(controllerIndex, inputString);
  }
}

/** Revert a player to local keyboard input */
export function disableRemoteInput(
  game: GameInstance,
  controllerIndex: number
): void {
  if (game.Module._disableExternalInput) {
    game.Module._disableExternalInput(controllerIndex);
  }
}

/** Check if a player is using remote input */
export function isRemoteInputActive(
  game: GameInstance,
  controllerIndex: number
): boolean {
  if (game.Module._isExternalInputActive) {
    return game.Module._isExternalInputActive(controllerIndex) === 1;
  }
  return false;
}