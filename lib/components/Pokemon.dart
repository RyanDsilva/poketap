import 'dart:ui';
import 'package:poketap/poketap.dart';

class Pokemon {
  final PokeTap game;
  bool isCaptured = false;
  bool isOffScreen = false;
  Rect pokeRect;
  Paint pokePaint;

  Pokemon(this.game, double x, double y) {
    pokeRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    pokePaint = Paint();
    pokePaint.color = Color(0xffff6b6b);
  }

  void render(Canvas c) {
    c.drawRect(pokeRect, pokePaint);
  }

  void update(double t) {
    if (isCaptured) {
      pokeRect = pokeRect.translate(0, game.tileSize * 12 * t);
    }
    if (pokeRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    isCaptured = true;
    pokePaint.color = Color(0xfffdcb6e);
    game.spawnPokemon();
  }
}
