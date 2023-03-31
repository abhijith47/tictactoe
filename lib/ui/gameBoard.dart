import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<List<String>> _gameState = List.generate(3, (_) => List.filled(3, ''));
  String currentPlayer = 'X';
  bool _twoPlayerMode = false;
  bool _checkGameWinner(String player) {
    // Check rows
    for (int gameRow = 0; gameRow < 3; gameRow++) {
      if (_gameState[gameRow][0] == player &&
          _gameState[gameRow][1] == player &&
          _gameState[gameRow][2] == player) {
        return true;
      }
    }

    // Check columns
    for (int gamecol = 0; gamecol < 3; gamecol++) {
      if (_gameState[0][gamecol] == player &&
          _gameState[1][gamecol] == player &&
          _gameState[2][gamecol] == player) {
        return true;
      }
    }

    // Check diagonals
    if (_gameState[0][0] == player &&
        _gameState[1][1] == player &&
        _gameState[2][2] == player) {
      return true;
    }

    if (_gameState[0][2] == player &&
        _gameState[1][1] == player &&
        _gameState[2][0] == player) {
      return true;
    }

    return false;
  }

  void _WinnerPopup(String winner) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hurray $winner won!',
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: !_twoPlayerMode
                          ? Colors.blueAccent
                          : Colors.greenAccent,
                      border: Border.all(
                        color: !_twoPlayerMode
                            ? Colors.blueAccent
                            : Colors.greenAccent,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Center(
                      child: Text('Play again',
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)))),
              onTap: () {
                Navigator.of(context).pop();
                _resetBoard();
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _checkGameTie() {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (_gameState[row][col] == '') {
          return false;
        }
      }
    }
    return true;
  }

  void _showTieDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Oops  it\'s a tie!',
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: !_twoPlayerMode
                          ? Colors.blueAccent
                          : Colors.greenAccent,
                      border: Border.all(
                        color: !_twoPlayerMode
                            ? Colors.blueAccent
                            : Colors.greenAccent,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Center(
                      child: Text('Play again',
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)))),
              onTap: () {
                Navigator.of(context).pop();
                _resetBoard();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _resetBoard() {
    setState(() {
      _gameState = List.generate(3, (_) => List.filled(3, ''));
      currentPlayer = 'X';
    });
  }

  void _handleTap(int row, int col) {
    if (_gameState[row][col] == '') {
      setState(() {
        _gameState[row][col] = currentPlayer;
        if (_checkGameWinner(currentPlayer)) {
          _WinnerPopup(currentPlayer);
        } else if (_checkGameTie()) {
          _showTieDialog();
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
          if (!_twoPlayerMode && currentPlayer == 'O') {
            // Make a move for the computer player
            Future.delayed(const Duration(milliseconds: 300), () async {
              await _makeComputerMove();
            });
            //   _makeComputerMove();
          }
        }
      });
    }
  }

  _makeComputerMove() {
    // Get all empty squares
    List<List<int>> emptySquares = [];
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (_gameState[row][col] == '') {
          emptySquares.add([row, col]);

          _gameState[row][col] = currentPlayer;
          if (_checkGameWinner(currentPlayer)) {
            _WinnerPopup(currentPlayer);
          } else if (_checkGameTie()) {
            _showTieDialog();
          }
          currentPlayer = 'X';
          setState(() {});

          return;
        }
      }
    }
  }

  Widget _gameBoard() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            for (int row = 0; row < 3; row++)
              Expanded(
                child: Row(
                  children: [
                    for (int col = 0; col < 3; col++)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _handleTap(row, col),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Center(
                                child: Text(_gameState[row][col],
                                    style: GoogleFonts.roboto(
                                        color: !_twoPlayerMode
                                            ? _gameState[row][col]
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'x'
                                                ? Colors.blueAccent
                                                : Colors.white
                                            : _gameState[row][col]
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'x'
                                                ? Colors.greenAccent
                                                : Colors.white,
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _gameModeSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LiteRollingSwitch(
            onTap: () {},
            onDoubleTap: () {},
            onSwipe: () {},
            //initial value
            value: _twoPlayerMode,
            textOn: ' multiplayer',
            textOff: 'v/s computer',
            colorOn: Colors.greenAccent,
            colorOff: Colors.blueAccent,
            iconOn: Icons.person,
            iconOff: Icons.computer,
            textSize: 10.0,
            onChanged: (bool state) {
              setState(() {
                _twoPlayerMode = state;
                _resetBoard();
              });
            },
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: !_twoPlayerMode ? Colors.blueAccent : Colors.greenAccent,
                borderRadius: const BorderRadius.all(Radius.circular(90))),
            child: Center(
              child: Container(
                height: 43,
                width: 43,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(90))),
                child: IconButton(
                    onPressed: (() {
                      _resetBoard();
                    }),
                    icon: Icon(
                      Icons.restore,
                      size: 25,
                      color: !_twoPlayerMode
                          ? Colors.blueAccent
                          : Colors.greenAccent,
                    )),
              ),
            ),
          )
        ],
      ),
    );

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Text('Two-player mode',
    //         style: GoogleFonts.roboto(fontSize: 12, color: Colors.white)),
    //     Switch(
    //       value: _twoPlayerMode,
    //       onChanged: (value) {
    //         setState(() {
    //           _twoPlayerMode = value;
    //           _resetBoard();
    //         });
    //       },
    //     ),
    //     Text('Single-player mode',
    //         style: GoogleFonts.roboto(fontSize: 12, color: Colors.white)),
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _gameModeSelector(),
          const SizedBox(height: 80),
          _gameBoard(),
        ],
      ),
    );
  }
}
