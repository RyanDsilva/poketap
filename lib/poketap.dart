import 'dart:ui';
import 'dart:math';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:poketap/components/Pokemon.dart';

class PokeTap extends Game {
  Size screenSize;
  double tileSize;
  Random rnd;
  List<Pokemon> pokemon;

  PokeTap() {
    initialize();
  }

  void initialize() async {
    pokemon = List<Pokemon>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    spawnPokemon();
  }

  void spawnPokemon() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    pokemon.add(Pokemon(this, x, y));
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff01a3a4);
    canvas.drawRect(bgRect, bgPaint);
    pokemon.forEach((Pokemon p) => p.render(canvas));
  }

  void update(double t) {
    pokemon.forEach((Pokemon p) => p.update(t));
    pokemon.removeWhere((Pokemon p) => p.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    pokemon.forEach((Pokemon pokemon) {
      if (pokemon.pokeRect.contains(d.globalPosition)) {
        pokemon.onTapDown();
      }
    });
  }
}
