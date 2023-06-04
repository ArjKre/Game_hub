import 'package:flutter/material.dart';
import 'package:game_hub/pages/loading.dart';
import 'package:game_hub/pages/home.dart';
import 'package:game_hub/pages/minesweeper.dart';
import 'package:game_hub/pages/snake.dart';
import 'package:game_hub/pages/tetris.dart';
import 'package:game_hub/pages/flappybird.dart';


void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/' : (context) => Loading(),
    '/home' : (context) => Home(),
    '/snake': (context) => Snake(),
    '/tetris': (context) => Tetris(),
    '/minesweeper': (context) => Minesweeper(),
    '/flappybird' : (context) => FlappyBid(),
  },
));