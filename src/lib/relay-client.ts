/**
 * WebSocket Relay Client
 *
 * Connects to the Deno Deploy WebSocket relay server for
 * lockstep multiplayer input forwarding.
 */

export type MessageType =
  | "create_room"
  | "join_room"
  | "input"
  | "ready"
  | "sync_check"
  | "leave_room"
  | "ping"
  | "room_created"
  | "player_joined"
  | "player_left"
  | "remote_input"
  | "game_start"
  | "error"
  | "pong";

export interface RelayMessage {
  type: MessageType;
  [key: string]: unknown;
}

export interface RoomCreatedMsg extends RelayMessage {
  type: "room_created";
  room_code: string;
  slot: number;
}

export interface RemoteInputMsg extends RelayMessage {
  type: "remote_input";
  frame: number;
  data: string;
  from_slot: number;
}

export interface GameStartMsg extends RelayMessage {
  type: "game_start";
  p1_char: string;
  p2_char: string;
}

type MessageHandler = (msg: RelayMessage) => void;

export class RelayClient {
  private ws: WebSocket | null = null;
  private sessionId: string;
  private roomCode: string | null = null;
  private handlers = new Map<MessageType, Set<MessageHandler>>();
  private reconnectAttempts = 0;
  private maxReconnectAttempts = 5;
  private relayUrl: string;

  constructor(relayUrl: string, sessionId: string) {
    this.relayUrl = relayUrl;
    this.sessionId = sessionId;
  }

  connect(): void {
    const url = `${this.relayUrl}?session_id=${this.sessionId}`;
    this.ws = new WebSocket(url);

    this.ws.onopen = () => {
      console.log("[Relay] Connected");
      this.reconnectAttempts = 0;
    };

    this.ws.onmessage = (event: MessageEvent) => {
      try {
        const msg = JSON.parse(event.data as string) as RelayMessage;
        this.dispatch(msg);
      } catch (e) {
        console.error("[Relay] Failed to parse message:", e);
      }
    };

    this.ws.onclose = () => {
      console.log("[Relay] Disconnected");
      this.attemptReconnect();
    };

    this.ws.onerror = (err) => {
      console.error("[Relay] Error:", err);
    };
  }

  disconnect(): void {
    if (this.ws) {
      this.ws.close();
      this.ws = null;
    }
  }

  on(type: MessageType, handler: MessageHandler): () => void {
    if (!this.handlers.has(type)) {
      this.handlers.set(type, new Set());
    }
    this.handlers.get(type)!.add(handler);
    // Return unsubscribe function
    return () => {
      this.handlers.get(type)?.delete(handler);
    };
  }

  sendInput(frame: number, data: string): void {
    this.send({
      type: "input",
      room_code: this.roomCode,
      frame,
      data,
    });
  }

  sendReady(): void {
    this.send({
      type: "ready",
      session_id: this.sessionId,
      room_code: this.roomCode,
    });
  }

  sendSyncCheck(frame: number, hash: string): void {
    this.send({
      type: "sync_check",
      room_code: this.roomCode,
      frame,
      hash,
    });
  }

  createRoom(): void {
    this.send({
      type: "create_room",
      session_id: this.sessionId,
    });
  }

  joinRoom(code: string): void {
    this.roomCode = code;
    this.send({
      type: "join_room",
      session_id: this.sessionId,
      room_code: code,
    });
  }

  leaveRoom(): void {
    this.send({
      type: "leave_room",
      session_id: this.sessionId,
      room_code: this.roomCode,
    });
  }

  getRoomCode(): string | null {
    return this.roomCode;
  }

  getSessionId(): string {
    return this.sessionId;
  }

  isConnected(): boolean {
    return this.ws !== null && this.ws.readyState === WebSocket.OPEN;
  }

  private send(msg: RelayMessage): void {
    if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      this.ws.send(JSON.stringify(msg));
    } else {
      console.warn("[Relay] Cannot send — not connected:", msg.type);
    }
  }

  private dispatch(msg: RelayMessage): void {
    const typeHandlers = this.handlers.get(msg.type);
    if (typeHandlers) {
      typeHandlers.forEach((handler) => handler(msg));
    }

    // Auto-track room code from server
    if (msg.type === "room_created") {
      this.roomCode = (msg as RoomCreatedMsg).room_code;
    }
  }

  private attemptReconnect(): void {
    if (this.reconnectAttempts >= this.maxReconnectAttempts) {
      console.error("[Relay] Max reconnect attempts reached");
      return;
    }
    this.reconnectAttempts++;
    const delay = Math.min(1000 * Math.pow(2, this.reconnectAttempts), 16000);
    console.log(`[Relay] Reconnecting in ${delay}ms (attempt ${this.reconnectAttempts})`);
    setTimeout(() => this.connect(), delay);
  }
}

/**
 * Helper: wire up the relay client to the game engine.
 * When a remote_input message arrives, inject it into WASM.
 */
export function connectRelayToGame(
  relay: RelayClient,
  injectFn: (playerIndex: number, inputString: string) => void,
  mySlot: number
): () => void {
  const unsub = relay.on("remote_input", (msg) => {
    const remoteMsg = msg as RemoteInputMsg;
    // The remote player is the other slot
    injectFn(remoteMsg.from_slot, remoteMsg.data);
  });

  const unsubStart = relay.on("game_start", (msg) => {
    const startMsg = msg as GameStartMsg;
    console.log(`[Game] Starting: ${startMsg.p1_char} vs ${startMsg.p2_char}`);
  });

  return () => {
    unsub();
    unsubStart();
  };
}