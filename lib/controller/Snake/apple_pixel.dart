import 'package:flutter/material.dart';

class ApplePixel extends StatelessWidget {
  const ApplePixel({Key? key}) : super(key: key);

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
              image: DecorationImage(image: AssetImage("assets/images/games/Snake/apple .png")),
              borderRadius: BorderRadius.circular(2)
          ),
        ),
      ),
    );
  }
}
