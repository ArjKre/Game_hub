import 'package:flutter/material.dart';

class BlankPixel extends StatelessWidget {
  const BlankPixel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.1),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/games/Snake/backgroundgrass.png")),
            borderRadius: BorderRadius.circular(2)
        ),
      ),
    );
  }
}
