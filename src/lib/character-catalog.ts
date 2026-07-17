/**
 * Character catalog — defines the roster of playable characters.
 *
 * In Phase 1, only characters bundled in game.data are available.
 * Phase 1.5+ will add characters fetched on-demand from R2.
 */

export interface CharacterInfo {
  /** Internal name (matches folder name under chars/) */
  id: string;
  /** Display name shown in UI */
  displayName: string;
  /** Author credit */
  author: string;
  /** Short description shown on char select */
  description: string;
  /** Approximate size for display purposes */
  sizeMB: number;
  /** Whether the character is bundled in game.data (true) or
   *  requires R2 streaming (false, Phase 1.5+) */
  bundled: boolean;
}

export const CHARACTERS: CharacterInfo[] = [
  {
    id: "Songoku",
    displayName: "Songoku",
    author: "Dolmexica",
    description: "Dragon Ball Z — balanced all-rounder. Bundled with engine.",
    sizeMB: 4,
    bundled: true,
  },
  {
    id: "Vegeta",
    displayName: "Vegeta",
    author: "CHOUJIN (2011)",
    description: "Dragon Ball Z — prince of Saiyans. Aggressive rushdown.",
    sizeMB: 4.3,
    bundled: true,
  },
  // Phase 1.5+ — these require R2 streaming, not yet playable
  // {
  //   id: "KnightmareSuperman",
  //   displayName: "Knightmare Superman",
  //   author: "Various",
  //   description: "Justice League — heavy bruiser.",
  //   sizeMB: 69,
  //   bundled: false,
  // },
  // {
  //   id: "Nightwing",
  //   displayName: "Nightwing",
  //   author: "O Illusionista",
  //   description: "Batman family — fast acrobat.",
  //   sizeMB: 30,
  //   bundled: false,
  // },
];

/** Get only the characters currently playable in Phase 1 */
export function getPlayableCharacters(): CharacterInfo[] {
  return CHARACTERS.filter((c) => c.bundled);
}

/** Find a character by ID */
export function getCharacterById(id: string): CharacterInfo | undefined {
  return CHARACTERS.find((c) => c.id === id);
}
