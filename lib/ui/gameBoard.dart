import 'package:flutter/material.dart';

import 'gameSquare.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<List<String>> _boardState = List.generate(3, (_) => List.filled(3, ''));

  String currentPlayer = 'X';

  void _onTapSquare(int row, int col) {
    setState(() {
      if (_boardState[row][col].isEmpty) {
        _boardState[row][col] = currentPlayer;
        _checkWinner();
        _togglePlayer();
      }
    });
  }

  void _checkWinner() {
    // Check for a winner and update game status
  }

  void _togglePlayer() {
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: 9,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        int row = index ~/ 3;
        int col = index % 3;
        return Square(
          value: _boardState[row][col],
          onTap: () => _onTapSquare(row, col),
        );
      },
    );
  }
}
