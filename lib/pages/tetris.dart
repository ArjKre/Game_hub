import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_hub/controller/Tetris/pixel.dart';
import 'package:game_hub/controller/Tetris/tetrominoes.dart';


///GAME BOARD
List<List<Tetrominoes?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class Tetris extends StatefulWidget {
  const Tetris({Key? key}) : super(key: key);

  @override
  State<Tetris> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {

  ///visibility of play button
  bool isVisible = true;

  ///current tetris piece
  TetrisPiece currentPiece = TetrisPiece(types: Tetrominoes.L);

  ///current Score
  int currentScore = 0;
  bool isScoreboardVisible = false;

  ///game over variable
  bool gameOver = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void StartGame() {
    ///frame refresh rate
    Duration frameRate = const Duration(milliseconds: 300);
    gameLoop(frameRate);

    currentPiece.initializePiece();
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {

        ///clear lines
        clearLines();

        ///check for landing
        checkLanding();

        ///check if game is over
        if (gameOver == true) {
          timer.cancel();

          ///Message box
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
        ///move current piece down
        currentPiece.movePiece(TetrisDirections.DOWN);
      });
    });
  }

  ///check for collision of tetris pieces (true or false statement)
  bool checkCollision(TetrisDirections direction) {
    ///loop through each position of the current piece
    for (int i = 0; i < currentPiece.tetrisposition.length; i++) {
      ///calculate the row and column of the current position
      int currentrow = (currentPiece.tetrisposition[i] / rowLength).floor();
      int currentcol = currentPiece.tetrisposition[i] % rowLength;

      ///adjust the row and col based on the direction
      if (direction == TetrisDirections.LEFT) {
        currentcol -= 1;
      } else if (direction == TetrisDirections.RIGHT) {
        currentcol += 1;
      }else if (direction == TetrisDirections.DOWN) {
        currentrow += 1;
      }

      ///check if the piece is out of bounds

      if (currentrow >= colLength ||
          currentcol < 0 ||
          currentcol >= rowLength) {
        return true;
      } else if (currentcol > 0 &&
          currentrow > 0 &&
          gameBoard[currentrow][currentcol] != null) {
        return true;
      }
    }

    ///if no collision are detected
    return false;
  }

  void checkLanding() {
    ///if going down is occupied
    if (checkCollision(TetrisDirections.DOWN)) {
      ///mark position as occupied
      for (int i = 0; i < currentPiece.tetrisposition.length; i++) {
        int currentrow = (currentPiece.tetrisposition[i] / rowLength).floor();
        int currentcol = currentPiece.tetrisposition[i] % rowLength;
        if (currentrow >= 0 && currentcol >= 0) {
          gameBoard[currentrow][currentcol] = currentPiece.types;
        }
      }

      ///once landed, create new piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    ///create random tetromino type
    Random rand = Random();

    ///create a new piece with random type
    Tetrominoes randomType =
        Tetrominoes.values[rand.nextInt(Tetrominoes.values.length)];
    currentPiece = TetrisPiece(types: randomType);
    currentPiece.initializePiece();

    ///game over is checked when a new piece is created
    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(TetrisDirections.LEFT)) {
      setState(() {
        currentPiece.movePiece(TetrisDirections.LEFT);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(TetrisDirections.RIGHT)) {
      setState(() {
        currentPiece.movePiece(TetrisDirections.RIGHT);
      });
    }
  }

  void rotatePiece() {
    currentPiece.rotatePiece();
  }

  void clearLines() {

    ///Loop through each row of game board from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      ///a variable to track if the row is full
      bool rowIsFull = true;

      ///Check if the row if full
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }

      }

      ///if row is full, clear the row and shift rows down
      if (rowIsFull) {
        ///move all rows above row down
        for (int r = row; r > 0; r--) {
          ///copy above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        ///set the top row to empty
        gameBoard[0] = List.generate((row), (index) => null);

        ///Increase the score !
        currentScore++;
      }
    }
  }

  bool isGameOver() {

    ///check if any columns in the top row are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    ///if the top row is empty, the game is not over
    return false;
  }

  void newGame() {
    ///new game board
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );
    gameOver = false;
    currentScore = 0;

    createNewPiece();

    StartGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            gameBoard = List.generate(
              colLength,
                  (i) => List.generate(
                rowLength,
                    (j) => null,
              ),
            );
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color(0xFF3d4993),
        centerTitle: true,
        title: Text(
          "TETRIS",
          style: TextStyle(
            fontFamily: 'Superstar',
            fontSize: 35.0,
            letterSpacing: 4,
          ),
        ),
      ),
      body: Container(
            color: Color(0xFF272f30),
        child: Stack(
          children: [

            ///Game Grid
            Container(
              child: GridView.builder(
                  itemCount: 150,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength),
                  itemBuilder: (context, index) {
                    ///get currentrow & currentcol of each index
                    int currentrow = (index / rowLength).floor();
                    int currentcol = index % rowLength;

                    ///falling piece
                    if (currentPiece.tetrisposition.contains(index)) {
                      return Pixel(color: currentPiece.types.color);
                    }

                    ///landed piece
                    else if (gameBoard[currentrow][currentcol] != null) {
                      final Tetrominoes? tetrominoType =
                          gameBoard[currentrow][currentcol];
                      return Pixel(color: tetrominoType?.color);
                    }

                    ///background pixel
                    else {
                      return Pixel(color: Color(0xFF26393d));
                      //  return Pixel(color: Color(0xFF49296b));
                    }
                  }),
            ),

            ///Game Controls
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 155,
                     // color: Colors.white,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/games/Tetris/tetrisback(2).jpg"),
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.fitWidth,
                            opacity: 0.75
                          ),
                        ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          ///Scoreboard
                          Visibility(
                            // visible: isScoreboardVisible,
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  )
                                ],
                                color: Color(0xff42adc1)
                              ),
                              child: Text(
                                "Score: " + currentScore.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  // color: Color.fromRGBO(18, 91, 73, 1),
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Metropolis',
                                ),
                              ),
                            ),
                          ),

                          ///Controls
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              ///left
                              InkWell(
                                onTap: () {
                                  moveLeft();
                                },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF192b57).withOpacity(0.9),
                                        Color(0XFF4747dd).withOpacity(0.9),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),

                              ///rotate
                              InkWell(
                                onTap: () {
                                  rotatePiece();
                                },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF192b57).withOpacity(0.9),
                                        Color(0XFF4747dd).withOpacity(0.9),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange,
                                  ),
                                  child: Icon(
                                    Icons.rotate_right_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              ///right
                              InkWell(
                                onTap: () {
                                  moveRight();
                                },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF192b57).withOpacity(0.9),
                                        Color(0XFF4747dd).withOpacity(0.9),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 50,
                                    color: Colors.white,
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
              ],
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
                          // margin: EdgeInsets.only(bottom: 200),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF00ff87),
                                Color(0xFF60efff),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          width: 150,
                          height: 60,
                          child: MaterialButton(
                            elevation: 2,
                            onPressed: () {
                              isVisible = !isVisible;
                              newGame();
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
