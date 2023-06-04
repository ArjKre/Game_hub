import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_hub/controller/local/homescreen_card.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void initState() {
    super.initState();

    /// System UI Settings
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF327E96),
              Color(0xFF08203E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            //sliver app bar
            SliverAppBar.medium(
              backgroundColor: Colors.transparent,
              elevation: 0,
              stretch: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.fadeTitle,
                ],
                background: Image(
                  image:
                      AssetImage("assets/images/local/appbar_background.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  opacity: AlwaysStoppedAnimation(.75),
                ),
                centerTitle: true,
                title: Text(
                  "G A M E   H U B",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'League',
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
              // actions: [
              //   IconButton(onPressed: () {}, icon: Icon(Icons.settings))
              // ],
            ),

            /// Sliver Homescreen
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),

                  Homescreen_Card(thumbnail: "assets/images/local/Snake_Homepage.png", routeString: '/snake', thumbnailFit: BoxFit.fitWidth),
                  Homescreen_Card(thumbnail: "assets/images/local/Minesweeper_Homepage.png", routeString: '/minesweeper', thumbnailFit: BoxFit.fitWidth),
                  Homescreen_Card(thumbnail: "assets/images/local/Tetris_Homepage.png", routeString: '/tetris', thumbnailFit: BoxFit.fitHeight),
                  Homescreen_Card(thumbnail: "assets/images/local/flappybird_homescreen.png", routeString: '/flappybird', thumbnailFit: BoxFit.fill),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
