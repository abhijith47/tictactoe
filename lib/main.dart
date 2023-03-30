import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/ui/gameBoard.dart';

void main() {
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const TicTacToeGame()));
}

class TicTacToeGame extends StatelessWidget {
  const TicTacToeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      home: TicTacToe(),
    );
  }
}
