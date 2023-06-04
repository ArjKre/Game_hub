import 'package:flutter/material.dart';

class Homescreen_Card extends StatelessWidget {
  var thumbnail;
  var routeString;
  var thumbnailFit;

  Homescreen_Card(
      {super.key,
      required this.thumbnail,
      required this.routeString,
      required this.thumbnailFit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeString);
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(thumbnail),
            fit: thumbnailFit,
          ),
          // color: Color.fromRGBO(231, 111, 81, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
