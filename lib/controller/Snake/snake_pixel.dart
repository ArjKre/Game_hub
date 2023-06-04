import 'package:flutter/material.dart';

class SnakePixel extends StatelessWidget {
  const SnakePixel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/games/Snake/backgroundgrass.png"))
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          decoration: BoxDecoration(
              // color: Color.fromRGBO(69, 115, 232,1),
            gradient: LinearGradient(
              colors: [
                Color(0xFF13223f),
                Color(0xFF35aea1),
                // Color(0xFFae0f07),
              ],
                  begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),
              borderRadius: BorderRadius.circular(100)
          ),
        ),
      ),
    );
  }
}