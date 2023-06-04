import 'package:flutter/material.dart';

class MineTile extends StatefulWidget {
  late bool revealed;
  late final property;
  bool showImage = false;

  MineTile({
    required this.revealed,
    required this.property,
  });

  @override
  State<MineTile> createState() => _MineTileState();
}

class _MineTileState extends State<MineTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.property,
      onLongPressUp: () {
        setState(() {
          // widget.showImage = true;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            image: widget.showImage
                ? DecorationImage(
                    image: AssetImage(
                        "assets/images/games/minesweeper/red-flag.png"),
                    fit: BoxFit.contain)
                : (widget.revealed)
                    ? DecorationImage(
                        image: AssetImage(
                            "assets/images/games/minesweeper/land-mine.png"),
                        fit: BoxFit.contain)
                    : null,
            borderRadius: BorderRadius.circular(4),
            color: widget.revealed ? Colors.transparent : Color(0xFF22141c),
          ),
        ),
      ),
    );
  }
}
