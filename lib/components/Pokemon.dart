import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:poketap/poketap.dart';
import 'package:poketap/util/Views.dart';

class Pokemon {
  final PokeTap game;
  bool isCaptured = false;
  bool isOffScreen = false;
  Rect pokeRect;
  Sprite pokeSprite;
  Sprite deadSprite;
  Offset targetLocation;

  Pokemon(this.game, double x, double y) {
    pokeRect = Rect.fromLTWH(x, y, game.tileSize * 2, game.tileSize * 2);
    pokeSprite = Sprite('pikachu-active.png');
    deadSprite = Sprite('pikachu.png');
    setTargetLocation();
  }

  double get speed => game.tileSize * 3;

  void setTargetLocation() {
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() *
        (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
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
    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(pokeRect.left, pokeRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      pokeRect = pokeRect.shift(stepToTarget);
    } else {
      pokeRect = pokeRect.shift(toTarget);
      setTargetLocation();
    }
  }

  void onTapDown() {
    if (!isCaptured) {
      isCaptured = true;
      Flame.audio.disableLog();
      Flame.audio.play('pikachu.ogg', volume: 0.4);

      if (game.activeView == View.Playing) {
        game.score += 1;
        if (game.score > (game.storage.getInt('highscore') ?? 0)) {
          game.storage.setInt('highscore', game.score);
          game.highscoreDisplay.updateHighscore();
        }
      }
    }
  }
}
