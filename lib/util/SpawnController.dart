import 'package:poketap/components/Pokemon.dart';
import 'package:poketap/poketap.dart';

class Spawner {
  final PokeTap game;
  final int maxSpawnInterval = 1500;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 7;

  int currentInterval;
  int nextSpawn;

  Spawner(this.game) {
    start();
    game.spawnPokemon();
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.pokemon.forEach((Pokemon pokemon) => pokemon.isCaptured = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    game.pokemon.forEach((Pokemon pokemon) {
      if (!pokemon.isCaptured) livingFlies += 1;
    });

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnPokemon();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}
