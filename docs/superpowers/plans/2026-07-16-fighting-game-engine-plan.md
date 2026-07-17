# Fighting Game Engine — Implementation Plan

**Date:** 2026-07-16
**Status:** In Progress

## Task Tracker

### Phase 0: Engine → WASM
- [x] 01. Clone Dolmexica Infinite + Prism engine
- [x] 02. Fix Vector2D API change in playerdefinition.cpp (6 call sites)
- [x] 03. Create sound_web.cpp (SDL_mixer music replacement for FMOD)
- [x] 04. Create soundeffect_web.cpp (SDL_mixer SFX replacement for FMOD)
- [x] 05. Download zstd headers for compression support
- [x] 06. Write build-wasm.sh (Prism + Dolmexica + asset packaging)
- [x] 07. Build WASM successfully (game.wasm 3.2MB + game.js 180KB)
- [ ] 08. Download and validate 3 test characters
- [ ] 09. Rebuild WASM with assets bundled via file_packager
- [ ] 10. Verify characters load with emrun

### Phase 0.5: Input Bridge
- [ ] 11. Add setExternalPlayerInput() C function in Dolmexica
- [ ] 12. Expose to JS via Emscripten cwrap
- [ ] 13. Test remote input injection

### Phase 1: Frontend + Relay MVP
- [ ] 14. Next.js game page with canvas component
- [ ] 15. Keyboard input capture → MUGEN input strings
- [ ] 16. Touch controls (D-pad + action buttons)
- [ ] 17. Deno Deploy WebSocket relay server
- [ ] 18. Room creation/joining flow
- [ ] 19. End-to-end test: two browsers, one room

### Phase 2: Polish
- [ ] 20. Neon DB schema + migrations
- [ ] 21. Character select screen
- [ ] 22. Upstash Redis room state cache
- [ ] 23. Cloudflare R2 asset delivery

### Phase 3: Scale
- [ ] 24. Spectator mode
- [ ] 25. Replay recording/playback
- [ ] 26. Ranked matchmaking

## Dependencies

- Tasks 11-13 depend on 08-10 (need working WASM with assets)
- Tasks 14-16 depend on 11-13 (need input bridge)
- Task 17 can start in parallel with 14-16
- Tasks 18-19 depend on all above