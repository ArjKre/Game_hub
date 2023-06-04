import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_hub/controller/minesweeper/minetile.dart';
import 'package:game_hub/controller/minesweeper/tile.dart';

class Minesweeper extends StatefulWidget {
  const Minesweeper({Key? key}) : super(key: key);

  //TODO: flags

  @override
  State<Minesweeper> createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  ///variables
  int rowLength = 10;
  int numberOfSquare = 10 * 10;

  ///Timer
  late Timer timer;
  int secondsPassed = 0;
  String formattedTime = '0:00';
  late String currentScoreTime ;
  bool _isTimerStop = false;

  /// FALSE if timer is still going TRUE if timer stoped

  ///play button visibility
  bool isVisible = true;

  ///when game over the user can't click on tile
  bool gamevOverEnable = false;

  /// [number of bombs around, reveald = true / false]
  var squareStatus = [];

  /// bomb locations
  int numberOfBombs = 10;
  late List<int> bombLocation = [];

  bool bombsRevealed = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    /// initially, each square has 0 bomb around, and is not revealed
    for (int i = 0; i < numberOfSquare; i++) {
      squareStatus.add([0, false]);
    }
  }

  void startTimer() {
    _isTimerStop = false;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        secondsPassed++;
        formattedTime = formatTime(secondsPassed);
      }),
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedTime =
        '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  void stopTimer() {
    timer.cancel();
    _isTimerStop = true;
  }

  void resetTimer() {
    setState(() {
      secondsPassed = 0;
      formattedTime = '0:00';
    });
  }

  void startGame() {
    randomBombLocation();

    /// initially, each square has 0 bomb around, and is not revealed
    for (int i = 0; i < numberOfSquare; i++) {
      squareStatus[i][1] = false;
    }
    scanBomb();
  }

  void restartGame() {
    randomBombLocation();
    setState(() {
      gamevOverEnable = false;
      bombsRevealed = false;
      for (int i = 0; i < numberOfSquare; i++) {
        squareStatus[i][1] = false;
      }
      scanBomb();
    });
  }

  void checkWinner() {
    ///check how many boxes yet to reveal
    int unrevealedBoxes = 0;
    for (int i = 0; i < numberOfSquare; i++) {
      if (squareStatus[i][1] == false) {
        unrevealedBoxes++;
      }
    }

    ///if this number is the same as the number of bombs, then palyer win
    if (unrevealedBoxes == bombLocation.length) {
      setState(() {
        stopTimer();
        currentScoreTime = formattedTime;
      });
      playerWon();
      setState(() {
        startTimer();
      });
    }
  }

  void gameOver() {
    gamevOverEnable = true;
  }

  void randomBombLocation() {
    Random rand = Random();
    Set<int> uniqueNumbers = Set<int>();
    while (uniqueNumbers.length < 10) {
      int randNumbers = rand.nextInt(99) + 1;
      uniqueNumbers.add(randNumbers);
    }
    bombLocation = uniqueNumbers.toList();
  }

  void revealBoxNumber(int index) {
    ///reveals box if its 1,2,3 etc
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
    }

    /// if clicked box is 0
    else if (squareStatus[index][0] == 0) {
      setState(() {
        squareStatus[index][1] = true;

        if (index % rowLength != 0) {
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumber(index - 1);
          }

          squareStatus[index - 1][1] = true;
        }

        ///top left box
        if (index % rowLength != 0 && index >= rowLength) {
          if (squareStatus[index - 1 - rowLength][0] == 0 &&
              squareStatus[index - 1 - rowLength][1] == false) {
            revealBoxNumber(index - 1 - rowLength);
          }
          squareStatus[index - 1 - rowLength][1] = true;
        }

        ///top box
        if (index >= rowLength) {
          if (squareStatus[index - rowLength][0] == 0 &&
              squareStatus[index - rowLength][1] == false) {
            revealBoxNumber(index - rowLength);
          }
          squareStatus[index - rowLength][1] == true;
        }

        ///top right
        if (index >= rowLength && index % rowLength != rowLength - 1) {
          if (squareStatus[index + 1 - rowLength][0] == 0 &&
              squareStatus[index + 1 - rowLength][1] == false) {
            revealBoxNumber(index + 1 - rowLength);
          }
          squareStatus[index + 1 - rowLength][1] = true;
        }

        ///right box
        if (index % rowLength != rowLength - 1) {
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxNumber(index + 1);
          }
          squareStatus[index + 1][1] = true;
        }

        ///bottom right
        if (index < rowLength - rowLength &&
            index % rowLength != rowLength - 1) {
          if (squareStatus[index + 1 + rowLength][0] == 0 &&
              squareStatus[index + 1 + rowLength][1] == false) {
            revealBoxNumber(index + 1 + rowLength);
          }

          squareStatus[index + 1 + rowLength][1] = true;
        }

        ///bottom box
        if (index < numberOfSquare - rowLength) {
          if (squareStatus[index + 1 + rowLength][0] == 0 &&
              squareStatus[index + rowLength][1] == false) {
            revealBoxNumber(index + rowLength);
          }

          squareStatus[index + rowLength][1] = true;
        }

        ///bottom left
        if (index < numberOfSquare - rowLength && index % rowLength != 0) {
          if (squareStatus[index - 1 + rowLength][0] == 0 &&
              squareStatus[index - 1 + rowLength][1] == false) {
            revealBoxNumber(index - 1 + rowLength);
          }
          squareStatus[index - 1 + rowLength][1] = true;
        }
      });
    }
  }

  ///reveals how many mines are near the current box
  void scanBomb() {
    for (int i = 0; i < numberOfSquare; i++) {
      int numberofBombAround = 0;

      ///check square to the left,
      if (bombLocation.contains(i - 1) && i % rowLength != 0) {
        numberofBombAround++;
      }

      ///check square to the top left,
      if (bombLocation.contains(i - 1 - rowLength) &&
          i % rowLength != 0 &&
          i >= rowLength) {
        numberofBombAround++;
      }

      ///check square to the top,
      if (bombLocation.contains(i - rowLength) && i >= rowLength) {
        numberofBombAround++;
      }

      ///check square to the top right,
      if (bombLocation.contains(i + 1 - rowLength) &&
          i % rowLength != rowLength - 1 &&
          i >= rowLength) {
        numberofBombAround++;
      }

      ///check square to the right,
      if (bombLocation.contains(i + 1) && i % rowLength != rowLength - 1) {
        numberofBombAround++;
      }

      ///check square to the bottom right,
      if (bombLocation.contains(i + 1 + rowLength) &&
          i % rowLength != rowLength - 1 &&
          i < numberOfSquare - rowLength) {
        numberofBombAround++;
      }

      ///check square to the bottom ,
      if (bombLocation.contains(i + rowLength) &&
          i < numberOfSquare - rowLength) {
        numberofBombAround++;
      }

      ///check square to the bottom left,
      if (bombLocation.contains(i - 1 + rowLength) &&
          i < numberOfSquare - rowLength &&
          i % rowLength != 0) {
        numberofBombAround++;
      }

      ///add total number of bombs around to square status
      setState(() {
        squareStatus[i][0] = numberofBombAround;
      });
    }
  }

  playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFF747180),
            title: Center(
              child: Text(
                '😭Y O U   L O S T😭',
                style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 24,
                ),
              ),
            ),
          );
        });
  }

  playerWon() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFF747180),
            title: Center(
              child: Column(
                children: [
                  Text(
                    '🎊Y O U   W O N🎊',
                    style: TextStyle(
                      fontFamily: 'Metropolis',
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    '⏰ ${currentScoreTime}',
                    style: TextStyle(
                      fontFamily: 'Metropolis',
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
          "MINESWEEPER",
          style: TextStyle(
            fontFamily: 'Superstar',
            fontSize: 35.0,
            letterSpacing: 6,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/games/minesweeper/minebackground.png"),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
            opacity: 0.75,
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xFF3a003a),
              Color(0xFFF89B29),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 220),
              // height: 700,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/games/minesweeper/minbackground.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment(0, 0),
                  opacity: 0.75,
                ),
              ),
            ),

            Column(
              children: [
                ///mines, restart & time
                Container(
                  height: 70,
                  margin: EdgeInsets.only(top: 143),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///TOTAL Mines
                      Container(
                        margin: EdgeInsets.only(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              bombLocation.length.toString(),
                              style: TextStyle(
                                fontFamily: 'Metropolis',
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'MINES',
                              style: TextStyle(
                                  fontFamily: 'Metropolis',
                                  fontSize: 35,
                                  letterSpacing: 2,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      ///restart button
                      GestureDetector(
                        onTap: () {
                         resetTimer();
                         restartGame();
                         },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                          margin: EdgeInsets.only(top: 5),
                          child: Icon(Icons.refresh, size: 50),
                        ),
                      ),

                      ///Timer
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${formattedTime}',
                              style: TextStyle(
                                fontFamily: 'Metropolis',
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'TIMER',
                              style: TextStyle(
                                  fontFamily: 'Metropolis',
                                  fontSize: 35,
                                  letterSpacing: 2,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///game grid
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 115),
                height: 500,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquare,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: rowLength),
                    itemBuilder: (context, index) {
                      if (bombLocation.contains(index)) {
                        return

                            ///MINES
                            MineTile(
                          revealed: bombsRevealed,
                          property: () {
                            setState(() {
                              bombsRevealed = true;
                              resetTimer();
                              gameOver();
                            });
                            playerLost();
                          },
                        );
                      } else {
                        ///TILES
                        return Tile(
                          child: squareStatus[index][0],
                          revealed: squareStatus[index][1],
                          property: () {
                            ///reveal current box
                            if (!gamevOverEnable) {
                              /// !gameOveEnable == true
                              revealBoxNumber(index);
                              checkWinner();
                            }
                          },
                        );
                      }
                    }),
              ),
            ),

            ///Play Button
            Visibility(
              visible: isVisible,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 235, 0, 0),
                          width: 150,
                          height: 60,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFFf94848),
                            elevation: 2,
                            onPressed: () {
                              startGame();
                              setState(() {
                                startTimer();
                              });
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
          ],
        ),
      ),
    );
  }
}
