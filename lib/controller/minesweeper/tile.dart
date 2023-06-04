import 'package:flutter/material.dart';

// class Tile extends StatelessWidget {
//
//   var child;
//   bool revealed;
//   final property;
//   final flagproperty;
//   bool showImage = true;
//
//   Tile({required this.child,required this.revealed, required this.property,required this.flagproperty,required this.showImage});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: property,
//       onLongPressUp: flagproperty,
//       child: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: Container(
//           decoration: BoxDecoration(
//             image: showImage? DecorationImage(
//               image:  AssetImage("assets/images/games/minesweeper/red-flag.png"),
//               fit: BoxFit.fitHeight
//             ) : null,
//             borderRadius: BorderRadius.circular(4),
//             // color: Color(0xFFF89B29),
//             color: revealed? Colors.orange[200] : Colors.orangeAccent,
//           ),
//           child: Center(
//             child: Text(
//               revealed ? child.toString() : "",
//               // child.toString(),
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class Tile extends StatefulWidget {

    var child;
    bool revealed;
    final property;
    bool showImage = false;

    Tile({required this.child,required this.revealed, required this.property});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.property,
      onLongPressUp: () {
        // widget.showImage = true;
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            image:  widget.showImage? DecorationImage(
                image:  AssetImage("assets/images/games/minesweeper/red-flag.png"),
                fit: BoxFit.contain
            ) : null,
            borderRadius: BorderRadius.circular(4),
            color: widget.revealed ? (widget.child == 0 ? Color(0xFFF89B29).withOpacity(0.1) : Colors.orangeAccent) : Color(0xFF22141c),
            // color: Color(0xFFF89B29),
          ),
          child: Center(
            child: Text(
              widget.revealed ? (widget.child == 0 ? "" : widget.child.toString()) : "",
              style: TextStyle(
                color: widget.child == 1 ? Colors.blue : (widget.child == 2) ? Colors.green : (widget.child == 3) ? Colors.red : (widget.child == 4) ? Colors.purple : null,
                fontFamily: "Metropolis",
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
