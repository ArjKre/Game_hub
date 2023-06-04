import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

import 'package:game_hub/pages/home.dart';



class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override

  void initState() {
    super.initState();

    // ///Timer from loading screen to home page
    // Timer(Duration(seconds: 2), () {
    // Navigator.of(context).pushReplacementNamed('/home');
    // });


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
    return FlutterSplashScreen.fadeIn(
      duration: Duration(seconds: 3),
        defaultNextScreen: Home(),
        childWidget: Scaffold(
          backgroundColor: Color(0xFF327E96),
          appBar: AppBar(
            // backgroundColor:const Color.fromRGBO(42, 157, 143, 1),
            backgroundColor: Color(0xFF327E96),
            elevation: 0,
          ),
          body :  Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/local/game_hub2.png"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: SpinKitRing(
                  color: Colors.white,
                  size: 40,
                  duration: Duration(seconds: 1),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
