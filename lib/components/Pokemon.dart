import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:poketap/poketap.dart';

class Pokemon {
  final PokeTap game;
  bool isCaptured = false;
  bool isOffScreen = false;
  Rect pokeRect;
  Sprite pokeSprite;
  Sprite deadSprite;

  Pokemon(this.game, double x, double y) {
    pokeRect = Rect.fromLTWH(x, y, game.tileSize * 2, game.tileSize * 2);
    pokeSprite = Sprite('pikachu-active.png');
    deadSprite = Sprite('pikachu.png');
  }

  void render(Canvas c) {
    if (isCaptured) {
      deadSprite.renderRect(c, pokeRect.inflate(2));
    } else {
      pokeSprite.renderRect(c, pokeRect.inflate(2));
    }
  }

  void update(double t) {
    if (isCaptured) {
      pokeRect = pokeRect.translate(0, game.tileSize * 7.5 * t);
    }
    if (pokeRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    isCaptured = true;
    game.spawnPokemon();
  }
}
