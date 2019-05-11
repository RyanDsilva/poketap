import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:poketap/poketap.dart';
import 'package:poketap/util/Views.dart';

class StartButton {
  final PokeTap game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 2.75,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 3.5,
      game.tileSize * 2,
    );
    sprite = Sprite('start.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void onTapDown() {
    game.activeView = View.Playing;
    game.score = 0;
    game.pokeSpawner.start();
  }
}
