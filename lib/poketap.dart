import 'dart:ui';
import 'dart:math';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:poketap/components/Arena.dart';
import 'package:poketap/components/Pokemon.dart';

class PokeTap extends Game {
  Size screenSize;
  double tileSize;
  Random rnd;
  List<Pokemon> pokemon;
  Arena background;

  PokeTap() {
    initialize();
  }

  void initialize() async {
    pokemon = List<Pokemon>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    background = Arena(this);
    spawnPokemon();
  }

  void spawnPokemon() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize * 2);
    double y = rnd.nextDouble() * (screenSize.height - tileSize * 2);
    pokemon.add(Pokemon(this, x, y));
  }

  void render(Canvas canvas) {
    background.render(canvas);
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
