import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final String value;
  final void Function() onTap;

  Square({this.value = '', required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(fontSize: 48.0),
          ),
        ),
      ),
    );
  }
}
