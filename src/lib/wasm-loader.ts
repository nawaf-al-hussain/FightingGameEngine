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
    _main: () => void;
    _setExternalPlayerInput: (playerIndex: number, inputStr: string) => void;
    _disableExternalInput: (playerIndex: number) => void;
    _isExternalInputActive: (playerIndex: number) => number;
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
 * Also sets locateFile() so Emscripten fetches game.wasm and game.data from
 * /game/ regardless of the current page URL. Without this, the loader uses
 * page-relative paths and 404s when the page isn't at the site root.
 *
 * FIX-PRELOAD: Wraps FS_preloadFile to wait for WASM compilation
 * (Module._main being exposed) before processing. The Emscripten
 * file_packager IIFE runs at script eval, kicks off a fetch. If the
 * fetch resolves before WASM compilation completes, FS_preloadFile is
 * called before HEAP8 is set, causing MEMFS write to crash with
 * "Cannot read properties of undefined (reading 'buffer')".
 * Module._main is set inside receiveInstance, AFTER updateMemoryViews
 * sets HEAP8, so waiting for _main guarantees HEAP8 is ready. No
 * deadlock: FS_preloadFile doesn't depend on runDependencies, and
 * run() awaits runDependencies which includes 'datafile_...'.
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

    // Cache-bust: ensure each load gets a fresh copy of game.wasm/game.data
    // so updates are picked up immediately rather than waiting for the
    // 1-hour Cache-Control max-age to expire.
    const cacheBust = Date.now();

    const w = window as unknown as Record<string, unknown>;
    const existingConfig = (w.Module as Record<string, unknown> | undefined) || {};

    w.Module = {
      ...existingConfig,
      locateFile: (path: string) => `/game/${path}?v=${cacheBust}`,
      noInitialRun: true,
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

    // Create a WASM-ready promise that FS_preloadFile can wait on.
    // Resolves when Module._main is exposed (set inside assignWasmExports,
    // called from receiveInstance, BEFORE run()). At that point HEAP8 is set.
    const wasmReady = new Promise<void>((resolveWasm) => {
      const checkInterval = setInterval(() => {
        const m = w.Module as { _main?: unknown } | undefined;
        if (m && typeof m._main === "function") {
          clearInterval(checkInterval);
          resolveWasm();
        }
      }, 5);
      setTimeout(() => clearInterval(checkInterval), 30000);
    });

    // FIX-PRELOAD: Patch FS_preloadFile to wait for WASM compilation.
    // The file_packager IIFE runs at script eval, kicks off a fetch.
    // If the fetch resolves before WASM compilation completes, FS_preloadFile
    // is called before HEAP8 is set, causing MEMFS write to crash with
    // "Cannot read properties of undefined (reading 'buffer')".
    // By waiting for Module._main (which is set in receiveInstance, AFTER
    // updateMemoryViews), we guarantee HEAP8 is initialized before any
    // preload write happens. No deadlock: FS_preloadFile doesn't depend
    // on runDependencies, and run() awaits runDependencies which includes
    // the 'datafile_...' dependency added by runWithFS.
    const patchInterval = setInterval(() => {
      const M = w.Module as
        | (Record<string, unknown> & { FS_preloadFile?: (...args: unknown[]) => Promise<unknown> })
        | undefined;
      if (!M || typeof M.FS_preloadFile !== "function" || (M as { _fsPreloadPatched?: boolean })._fsPreloadPatched) {
        return;
      }
      const orig = M.FS_preloadFile;
      (M as { _fsPreloadPatched?: boolean })._fsPreloadPatched = true;

      M.FS_preloadFile = async (...args: unknown[]) => {
        await wasmReady;
        return orig.apply(M, args);
      };
      clearInterval(patchInterval);
    }, 5);
    setTimeout(() => clearInterval(patchInterval), 30000);
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