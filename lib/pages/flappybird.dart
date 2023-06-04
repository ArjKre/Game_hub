import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_hub/controller/flappybird/barrier.dart';
import 'package:game_hub/controller/flappybird/bird.dart';

class FlappyBid extends StatefulWidget {
  @override
  _FlappyBirdState createState() => _FlappyBirdState();
}

class _FlappyBirdState extends State<FlappyBid> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  double barrierXone = 1.8;
  double barrierXtwo = 1.8 + 1.5;
  double barrierXthree = 1.8 + 3;
  bool gameStarted = false;
  int score = 0;
  int highscore = 0;

  @override
  void initState() {
    setState(() {
      birdYaxis = 0;
      time = 0;
      height = 0;
      initialHeight = birdYaxis;
      barrierXone = 1.8;
      barrierXtwo = 1.8 + 1.5;
      barrierXthree = 1.8 + 3;
      gameStarted = false;
      score = 0;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  bool checkLose() {
    if (barrierXone < 0.2 && barrierXone > -0.2) {
      if (birdYaxis < -0.3 || birdYaxis > 0.7) {
        return true;
      }
    }
    if (barrierXtwo < 0.2 && barrierXtwo > -0.2) {
      if (birdYaxis < -0.8 || birdYaxis > 0.4) {
        return true;
      }
    }
    if (barrierXthree < 0.2 && barrierXthree > -0.2) {
      if (birdYaxis < -0.4 || birdYaxis > 0.7) {
        return true;
      }
    }
    return false;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        if (barrierXone < -2) {
          score++;
          barrierXone += 4.5;
        } else {
          barrierXone -= 0.04;
        }
        if (barrierXtwo < -2) {
          score++;

          barrierXtwo += 4.5;
        } else {
          barrierXtwo -= 0.04;
        }
        if (barrierXthree < -2) {
          score++;

          barrierXthree += 4.5;
        } else {
          barrierXthree -= 0.04;
        }
      });
      if (birdYaxis > 1.3 || checkLose()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Text(
              "GAME OVER",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Metropolis"
              ),
            ),
            content: Text(
              "Score: " +
                  score.toString() +
                  "\n" +
                  "High Score: " +
                  highscore.toString(),
              style: TextStyle(color: Colors.white,fontFamily: "Metropolis"),
              maxLines: 2,
            ),
            actions: [
              TextButton(
                child: Text(
                  "PLAY AGAIN",
                  style: TextStyle(color: Colors.white,fontFamily: "Metropolis"),
                ),
                onPressed: () {
                  if (score > highscore) {
                    highscore = score;
                  }
                  initState();
                  setState(() {
                    gameHasStarted = false;
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4ec0ca),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color(0xff3da56d),
        centerTitle: true,
        title: Text(
          "FLAPPY BIRD",
          style: TextStyle(
            fontFamily: 'Superstar',
            fontSize: 35.0,
            letterSpacing: 4,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (gameHasStarted) {
            jump();
          } else {
            startGame();
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children:[
                  Container(
                  height: 500,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        alignment: Alignment(0, birdYaxis),
                        duration: Duration(milliseconds: 0),
                        // color: Colors.blue,
                        child: MyBird(),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/games/flappybird/flappybird_background2.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment(0, -0.3),
                        child: gameHasStarted
                            ? Text(" ")
                            : Text("T A P  T O  P L A Y",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'league',
                                    color: Colors.white)),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXone, 1.1),
                        duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 200.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXtwo, 1.1),
                        duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 300.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXthree, 1.1),
                        duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 100.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXone, -1.1),
                        duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 150.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXtwo, -1.1),
                        duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 100.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXthree, -1.1),
                        duration: Duration(milliseconds: 0),
                        child: Barrier(
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),
                ),
                  ///SCORE BOARD
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        // visible: isScoreboardVisible,
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Text(
                            score.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 84,
                                fontFamily: 'superstar'),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
              ),

              Container(
                height: 15,
                color: Color(0xFF3ca56d),
                // color: Color(0xFF5de270),
              ),
              Expanded(
                child: Container(
                  // color: Colors.brown,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/games/flappybird/dirtBackground.jpg"
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.9
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
