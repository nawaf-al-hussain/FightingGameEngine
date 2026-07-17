# Deno Relay — WebSocket Protocol

## Client → Server Messages

### 1. `create_room`
```json
{ "type": "create_room", "session_id": "abc123" }
```
Response: `room_created` with `room_code`

### 2. `join_room`
```json
{ "type": "join_room", "session_id": "abc123", "room_code": "A1B2C3" }
```

### 3. `input`
```json
{ "type": "input", "room_code": "A1B2C3", "frame": 42, "data": "Ua" }
```
`data` is a MUGEN input string (e.g. "U" = up, "a" = light punch, "Fb" = forward + medium kick)

### 4. `ready`
```json
{ "type": "ready", "session_id": "abc123", "room_code": "A1B2C3" }
```

### 5. `sync_check`
```json
{ "type": "sync_check", "room_code": "A1B2C3", "frame": 42, "hash": "deadbeef" }
```
Optional integrity check — each client sends a game state hash periodically.

### 6. `leave_room`
```json
{ "type": "leave_room", "session_id": "abc123", "room_code": "A1B2C3" }
```

### 7. `ping`
```json
{ "type": "ping", "ts": 1752748800000 }
```

## Server → Client Messages

### 1. `room_created`
```json
{ "type": "room_created", "room_code": "A1B2C3", "slot": 1 }
```

### 2. `player_joined`
```json
{ "type": "player_joined", "slot": 2, "session_id": "xyz789" }
```

### 3. `player_left`
```json
{ "type": "player_left", "slot": 1 }
```

### 4. `remote_input`
```json
{ "type": "remote_input", "frame": 42, "data": "Db", "from_slot": 1 }
```
Forwarded input from the other player.

### 5. `game_start`
```json
{ "type": "game_start", "p1_char": "KnightmareSuperman", "p2_char": "Nightwing" }
```

### 6. `error`
```json
{ "type": "error", "code": "ROOM_FULL", "message": "Room is full" }
```

## Lockstep Logic

```
Frame N:
  1. Client A sends input for frame N
  2. Client B sends input for frame N
  3. Relay receives A's input → buffers, sends to B
  4. Relay receives B's input → buffers, sends to A
  5. Both clients now have both inputs for frame N → advance simulation
```

If a client doesn't receive the opponent's input within 200ms, it pauses and sends a `sync_check`. The relay can request a re-send.

## WASM Input Bridge API

The C function exposed to JavaScript:
```c
void setExternalPlayerInput(int playerIndex, const char* inputString);
```

Called via Emscripten:
```js
Module.ccall('setExternalPlayerInput', 'void', ['number', 'string'], [2, "Db"]);
```

This injects a remote player's input directly into the game engine's input pipeline, bypassing the normal keyboard/SDL input path.