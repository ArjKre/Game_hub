import 'package:flutter/material.dart';
import 'package:game_hub/pages/tetris.dart';

///Grid dimensions
int rowLength = 10;
int colLength = 15;

enum TetrisDirections { DOWN, LEFT, RIGHT }

enum Tetrominoes {
  L(Colors.orange),
  J(Colors.blue),
  I(Colors.pink),
  O(Colors.yellow),
  S(Colors.green),
  Z(Colors.red),
  T(Colors.purple);

  const Tetrominoes(this.color);

  final Color color;
}

class TetrisPiece {
  Tetrominoes types;

  TetrisPiece({required this.types});

  ///the piece is just a list of integers.
  List<int> tetrisposition = [];

  ///generate the integers
  void initializePiece() {
    switch (types) {
      case Tetrominoes.L:
        tetrisposition = [-26, -16, -6, -5];
        break;
      case Tetrominoes.I:
        tetrisposition = [-4, -5, -6, -7];
        break;
      case Tetrominoes.J:
        tetrisposition = [-25, -15, -5, -6];
        break;
      case Tetrominoes.O:
        tetrisposition = [-15, -16, -5, -6];
        break;
      case Tetrominoes.S:
        tetrisposition = [-15, -14, -6, -5];
        break;
      case Tetrominoes.Z:
        tetrisposition = [-17, -16, -6, -5];
        break;
      case Tetrominoes.T:
        tetrisposition = [-26, -16, -6, -15];
        break;
    }
  }

  ///move piece
  void movePiece(TetrisDirections tetrisDirections) {
    switch (tetrisDirections) {
      case TetrisDirections.DOWN:
        for (int i = 0; i < tetrisposition.length; i++) {
          tetrisposition[i] += rowLength;
        }
        break;
      case TetrisDirections.LEFT:
        for (int i = 0; i < tetrisposition.length; i++) {
          tetrisposition[i] -= 1;
        }
        break;
      case TetrisDirections.RIGHT:
        for (int i = 0; i < tetrisposition.length; i++) {
          tetrisposition[i] += 1;
        }
        break;
    }
  }

  int rotateState = 1;

  void rotatePiece() {
    ///Lise new position
    List<int> newPosition = [];

    ///rotate the piece based on it's type
    switch (types) {
      case Tetrominoes.L:
        switch (rotateState) {
          case 0:

            ///get new position
            newPosition = [
              tetrisposition[1] - rowLength,
              tetrisposition[1],
              tetrisposition[1] + rowLength,
              tetrisposition[1] + rowLength + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:

            ///get new position
            newPosition = [
              tetrisposition[1] + rowLength,
              tetrisposition[1],
              tetrisposition[1] - rowLength,
              tetrisposition[1] - rowLength - 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:

            ///get new position
            newPosition = [
              tetrisposition[1] - 1,
              tetrisposition[1],
              tetrisposition[1] + 1,
              tetrisposition[1] + rowLength - 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:

            ///get new position
            newPosition = [
              tetrisposition[1] - rowLength + 1,
              tetrisposition[1],
              tetrisposition[1] + 1,
              tetrisposition[1]- 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetrominoes.J:
        switch (rotateState) {
          case 0:

          ///get new position
            newPosition = [
              tetrisposition[1] - rowLength,
              tetrisposition[1],
              tetrisposition[1] + rowLength,
              tetrisposition[1] + rowLength + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:

          ///get new position
            newPosition = [
              tetrisposition[1] - rowLength - 1,
              tetrisposition[1],
              tetrisposition[1] - 1,
              tetrisposition[1] + 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:

          ///get new position
            newPosition = [
              tetrisposition[1] + rowLength,
              tetrisposition[1],
              tetrisposition[1] - rowLength,
              tetrisposition[1] - rowLength + 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:

          ///get new position
            newPosition = [
              tetrisposition[1]  + 1,
              tetrisposition[1],
              tetrisposition[1] - 1,
              tetrisposition[1] + rowLength + 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetrominoes.I:
        switch (rotateState) {
          case 0:

          ///get new position
            newPosition = [
              tetrisposition[1] - 1,
              tetrisposition[1],
              tetrisposition[1] + 1,
              tetrisposition[1] + 2 ,
            ];

            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:

          ///get new position
            newPosition = [
              tetrisposition[1] - rowLength ,
              tetrisposition[1],
              tetrisposition[1] + rowLength,
              tetrisposition[1] + 2 * rowLength,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:

          ///get new position
            newPosition = [
              tetrisposition[1] + 1,
              tetrisposition[1],
              tetrisposition[1] - 1,
              tetrisposition[1] - 2,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:

          ///get new position
            newPosition = [
              tetrisposition[1]  + rowLength,
              tetrisposition[1],
              tetrisposition[1] - rowLength,
              tetrisposition[1] - 2 * rowLength,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetrominoes.O:


      case Tetrominoes.S:
        switch (rotateState) {
          case 0:

          ///get new position
            newPosition = [
              tetrisposition[1],
              tetrisposition[1] + 1,
              tetrisposition[1] + rowLength - 1,
              tetrisposition[1] + rowLength ,
            ];

            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:

          ///get new position
            newPosition = [
              tetrisposition[0] - rowLength ,
              tetrisposition[0],
              tetrisposition[0] + 1,
              tetrisposition[0] + rowLength + 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:

          ///get new position
            newPosition = [
              tetrisposition[1],
              tetrisposition[1+1],
              tetrisposition[1] + rowLength - 1,
              tetrisposition[1] + rowLength,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:

          ///get new position
            newPosition = [
              tetrisposition[0]  - rowLength,
              tetrisposition[0],
              tetrisposition[0] + 1,
              tetrisposition[0] + rowLength + 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetrominoes.Z:
        switch (rotateState) {
          case 0:

          ///get new position
            newPosition = [
              tetrisposition[0] + rowLength - 2,
              tetrisposition[1],
              tetrisposition[2] + rowLength - 1,
              tetrisposition[3] + 1 ,
            ];

            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:

          ///get new position
            newPosition = [
              tetrisposition[0] - rowLength +2  ,
              tetrisposition[1],
              tetrisposition[2] -rowLength +1,
              tetrisposition[3] -1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:

          ///get new position
            newPosition = [
              tetrisposition[0] + rowLength - 2,
              tetrisposition[1],
              tetrisposition[2] + rowLength - 1,
              tetrisposition[3] + 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:

          ///get new position
            newPosition = [
              tetrisposition[0]  - rowLength + 2,
              tetrisposition[1],
              tetrisposition[2] - rowLength + 1,
              tetrisposition[3] - 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
        break;
      case Tetrominoes.T:
        switch (rotateState) {
          case 0:

          ///get new position
            newPosition = [
              tetrisposition[2] - rowLength,
              tetrisposition[2],
              tetrisposition[2] + 1,
              tetrisposition[2] + rowLength ,
            ];

            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:

          ///get new position
            newPosition = [
              tetrisposition[1] - 1 ,
              tetrisposition[1],
              tetrisposition[1] + 1,
              tetrisposition[1] +  rowLength,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:

          ///get new position
            newPosition = [
              tetrisposition[1] - rowLength,
              tetrisposition[1] - 1,
              tetrisposition[1] ,
              tetrisposition[1] + rowLength,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:

          ///get new position
            newPosition = [
              tetrisposition[2] - rowLength,
              tetrisposition[2] - 1,
              tetrisposition[2],
              tetrisposition[2] + 1,
            ];

            ///check that this new position is a valid position before assigning it to a real position
            if (piecePositionIsValid(newPosition)) {
              ///update new position
              tetrisposition = newPosition;

              ///update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  ///check valid position
  bool tetrisPositionIsValid(int position) {
    ///get currentrow & currentcol of current piece
    int currentrow = (position / rowLength).floor();
    int currentcol = position % rowLength;

    ///position already occupied
    if (currentrow < 0 ||currentcol < 0 ||gameBoard[currentrow][currentcol] != null) {
      return false;
    }

    return true;
  }

  /// check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      /// return false if any position is already taken
      if (!tetrisPositionIsValid(pos)) {
        return false;
      }

      /// get the col of position
      int col = pos % rowLength;

      /// check if the first or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    /// if there is a piece in the first cot and last cot, it is going through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}
