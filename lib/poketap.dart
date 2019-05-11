import 'dart:ui';
import 'dart:math';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:poketap/components/HighScores.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:poketap/components/Arena.dart';
import 'package:poketap/components/Pokemon.dart';
import 'package:poketap/components/Score.dart';
import 'package:poketap/components/Start.dart';
import 'package:poketap/util/SpawnController.dart';
import 'package:poketap/util/Views.dart';
import 'package:poketap/views/GameOver.dart';
import 'package:poketap/views/Home.dart';

class PokeTap extends Game {
  final SharedPreferences storage;
  AudioPlayer bgMusic;
  Size screenSize;
  double tileSize;
  Random rnd;
  List<Pokemon> pokemon;
  Arena background;
  View activeView = View.Home;
  HomeView homeView;
  LostView lostView;
  StartButton startButton;
  Spawner pokeSpawner;
  int score;
  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;

  PokeTap(this.storage) {
    initialize();
  }

  void initialize() async {
    pokemon = List<Pokemon>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    background = Arena(this);
    highscoreDisplay = HighscoreDisplay(this);
    pokeSpawner = Spawner(this);
    score = 0;
    Flame.audio.disableLog();
    bgMusic = await Flame.audio.loop('bg.mp3', volume: 0.25);
    // bgMusic.pause();
    homeView = HomeView(this);
    startButton = StartButton(this);
    lostView = LostView(this);
    scoreDisplay = ScoreDisplay(this);
  }

  void spawnPokemon() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize * 2);
    double y = rnd.nextDouble() * (screenSize.height - tileSize * 2);
    pokemon.add(Pokemon(this, x, y));
  }

  void render(Canvas canvas) {
    background.render(canvas);
    highscoreDisplay.render(canvas);
    if (activeView == View.Playing) {
      scoreDisplay.render(canvas);
    }
    pokemon.forEach((Pokemon p) => p.render(canvas));
    if (activeView == View.Home) {
      homeView.render(canvas);
    }
    if (activeView == View.Home || activeView == View.GameOver) {
      startButton.render(canvas);
    }
    if (activeView == View.GameOver) {
      lostView.render(canvas);
    }
  }

  void update(double t) {
    pokeSpawner.update(t);
    pokemon.forEach((Pokemon p) => p.update(t));
    pokemon.removeWhere((Pokemon p) => p.isOffScreen);
    if (activeView == View.Playing) {
      scoreDisplay.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.Home || activeView == View.GameOver) {
        startButton.onTapDown();
        isHandled = true;
      }
    }
    if (!isHandled) {
      bool didHitAFly = false;
      pokemon.forEach((Pokemon pokemon) {
        if (pokemon.pokeRect.contains(d.globalPosition)) {
          pokemon.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });
      if (activeView == View.Playing && !didHitAFly) {
        activeView = View.GameOver;
      }
    }
  }
}
