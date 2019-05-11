import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:poketap/poketap.dart';

class HomeView {
  final PokeTap game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height / 2) - (game.tileSize * 4),
      game.tileSize * 6,
      game.tileSize * 2.5,
    );
    titleSprite = Sprite('title.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {}
}
