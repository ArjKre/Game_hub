import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 100,
      child: Image.asset(
          'assets/images/games/flappybird/bird.png',
        fit: BoxFit.cover,
      ),
    );
  }
}