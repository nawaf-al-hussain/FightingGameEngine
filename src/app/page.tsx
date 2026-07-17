import "./styles/game.css";
import GameCanvas from "@/components/GameCanvas";

export default function Home() {
  return (
    <main className="game-page">
      <GameCanvas />
    </main>
  );
}