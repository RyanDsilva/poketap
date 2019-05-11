import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:poketap/poketap.dart';

class LostView {
  final PokeTap game;
  Rect rect;
  Sprite sprite;

  LostView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
    sprite = Sprite('gameOver.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}
}
