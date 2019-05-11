import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:poketap/poketap.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  Flame.images.loadAll(<String>[
    'bg.png',
    'pikachu.png',
    'title.png',
    'start.png',
    'gameOver.png',
  ]);
  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    'bg.mp3',
    'pikachu.ogg',
  ]);

  SharedPreferences storage = await SharedPreferences.getInstance();

  PokeTap game = PokeTap(storage);
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}
