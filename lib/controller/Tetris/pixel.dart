import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {

  var color;
  Pixel({super.key, required this.color,});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(0.5),
      child: Container(
        height: 0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),

      ),
    );
  }
}
