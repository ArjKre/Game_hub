import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_hub/controller/Snake/apple_pixel.dart';
import 'package:game_hub/controller/Snake/blank_pixel.dart';
import 'package:game_hub/controller/Snake/snake_pixel.dart';
import 'package:game_hub/controller/Snake/snake_pixel_head.dart';

class Snake extends StatefulWidget {
  const Snake({Key? key}) : super(key: key);

  @override
  State<Snake> createState() => _SnakeState();
}

enum snakeDirection { UP, DOWN, LEFT, RIGHT }

class _SnakeState extends State<Snake> {
  ///grid values
  int rowSize = 10;
  int squareCount = 150;

  ///int user score
  int currentScore = 0;
  bool isScoreboardVisible = false;

  ///visibility of play button
  bool isVisible = true;

  ///snake position
  List<int> snakePosition = [52, 53];

  ///Snake Head
  get snakeHead => snakePosition.last;

  ///apple position
  int applePosition = 56;

  ///snake direction at start of game
  var currentDirection = snakeDirection.RIGHT;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  ///start game
  void startGame() {
    isScoreboardVisible = !isScoreboardVisible;

    ///Frame refresh rate (FPS)
    Duration frameRate = const Duration(milliseconds: 150);

    Timer.periodic(frameRate, (Timer timer) {
      setState(() {
        ///snake movement
        updateSnake();

        ///if game over
        if (gameOver()) {
          timer.cancel();

          ///display message
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Game Over",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 16,
                      )),
                  content: Text(
                    "Score is: " + currentScore.toString(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Metropolis',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        newGame();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Play Again",
                        style: TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                );
              });
        }
      });
    });
  }

  void newGame() {
    isScoreboardVisible = !isScoreboardVisible;
    setState(() {
      snakePosition = [52, 53];
      currentScore = 0;
      applePosition = 56;
      currentDirection = snakeDirection.RIGHT;
      isVisible = true;
    });
  }

  ///snake eating apple
  void eatApple() {
    currentScore++;

    ///apple generated
    while (snakePosition.contains(applePosition)) {
      applePosition = Random().nextInt(squareCount - 1);
    }
  }

  ///Game Over
  bool gameOver() {
    ///when the snake runs on it's self or hits the wall.
    ///Happens when there is a duplicate position in the snake list

    ///body of snake with no head
    List<int> bodySnake = snakePosition.sublist(0, snakePosition.length - 1);

    if (bodySnake.contains(snakePosition.last)) {
      return true;
    }
    return false;
  }

  ///snake movements
  void updateSnake() {
    switch (currentDirection) {
      case snakeDirection.RIGHT:
        {
          if (snakePosition.last % rowSize == 9) {
            snakePosition.add(snakePosition.last + 1 - rowSize);
          } else {
            ///add a head
            snakePosition.add(snakePosition.last + 1);
          }
        }
        break;
      case snakeDirection.LEFT:
        {
          if (snakePosition.last % rowSize == 0) {
            snakePosition.add(snakePosition.last - 1 + rowSize);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
        }
        break;
      case snakeDirection.UP:
        {
          if (snakePosition.last < rowSize) {
            snakePosition.add(snakePosition.last - rowSize + 150);
          } else {
            snakePosition.add(snakePosition.last - 10);
          }
        }
        break;
      case snakeDirection.DOWN:
        {
          if (snakePosition.last > 150) {
            snakePosition.add(snakePosition.last + rowSize - 160);
          } else {
            snakePosition.add(snakePosition.last + rowSize);
          }
        }
        break;
    }

    ///snake eating apple
    if (snakePosition.last == applePosition) {
      eatApple();
    } else {
      ///remove tail
      snakePosition.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "SNAKE",
          style: TextStyle(
            fontFamily: 'Superstar',
            fontSize: 35.0,
            letterSpacing: 4,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0b2c24),
                Color(0xFF0b2c24),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/games/Snake/backgroundscoreboard.jpg"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              opacity: 0.75,
            )),
        child: Stack(
          // clipBehavior: Clip.none,
          children: [
            ///Scoreboard
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  // color: Colors.white70,
                  child: Visibility(
                    // visible: isScoreboardVisible,
                    child: Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Text(
                        currentScore.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFFf94848),
                            fontSize: 150,
                            fontFamily: 'League'),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            ///GAME GRID
            Center(
              child: Container(
                decoration: BoxDecoration(),
                margin: EdgeInsets.only(top: 113),
                height: 1000,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0 &&
                        currentDirection != snakeDirection.UP) {
                      currentDirection = snakeDirection.DOWN;
                    } else if (details.delta.dy < 0 &&
                        currentDirection != snakeDirection.DOWN) {
                      currentDirection = snakeDirection.UP;
                    }
                  },
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx < 0 &&
                        currentDirection != snakeDirection.RIGHT) {
                      currentDirection = snakeDirection.LEFT;
                    } else if (details.delta.dx > 0 &&
                        currentDirection != snakeDirection.LEFT) {
                      currentDirection = snakeDirection.RIGHT;
                    }
                  },
                  child: GridView.builder(
                      itemCount: squareCount,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: rowSize),
                      itemBuilder: (context, index) {
                        if (snakePosition.contains(index)) {
                          return const SnakePixel();
                        }else if (applePosition == index) {
                          return const ApplePixel();
                        }else{
                        return const BlankPixel();
                        }
                        // return Text(snakeHead.toString());
                      }),
                ),
              ),
            ),

            ///Play Button
            Visibility(
              visible: isVisible,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 200),
                          width: 150,
                          height: 60,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFFf94848),
                            elevation: 2,
                            onPressed: () {
                              startGame();
                              isVisible = !isVisible;
                            },
                            child: const Text(
                              "PLAY",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Metropolis",
                                fontSize: 24,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///bottom background
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/games/Snake/backgroundgrass.png"),
                        repeat: ImageRepeat.repeatX,
                        opacity: 0.75),
                  ),
                  height: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
