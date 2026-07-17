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

/** Mapping from browser KeyboardEvent.code to MUGEN input characters */
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
  KeyQ: "s", // Start
  Enter: "s", // Start (alternative)
};

/**
 * Convert a set of pressed key codes to a MUGEN input string.
 * MUGEN expects characters like "U" (up), "D" (down), "a" (light punch), etc.
 * Multiple simultaneous inputs are concatenated: "Fa" = forward + light punch.
 */
export function keyboardToInputString(activeKeys: Set<string>): string {
  let input = "";
  // Direction first (U/D/B/F), then actions (a/b/c/x/y/z/s)
  for (const key of ["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"]) {
    if (activeKeys.has(key)) {
      input += KEY_MAP[key];
    }
  }
  for (const key of [
    "KeyZ", "KeyX", "KeyC", "KeyA", "KeyS", "KeyD", "KeyQ", "Enter",
  ]) {
    if (activeKeys.has(key)) {
      input += KEY_MAP[key];
    }
  }
  return input;
}

/**
 * Load the game engine WASM module.
 * The game.js loader script must already be loaded (via <script> tag).
 */
export async function loadGameEngine(): Promise<GameInstance> {
  // The Emscripten loader creates a global `Module` or `createModule`.
  // We expect game.js to have been loaded as a regular script.
  const createModule = (window as unknown as Record<string, unknown>)
    .createModule as (() => Promise<unknown>) | undefined;

  if (typeof createModule === "function") {
    const mod = (await createModule()) as GameInstance["Module"];
    return { Module: mod } as GameInstance;
  }

  // Fallback: Module may already be initialized
  const existingModule = (window as unknown as Record<string, unknown>).Module;
  if (existingModule) {
    return { Module: existingModule as GameInstance["Module"] } as GameInstance;
  }

  throw new Error(
    "Game engine not loaded. Ensure public/game/game.js is loaded before calling loadGameEngine()."
  );
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