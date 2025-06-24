import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Calculatorbutton extends StatelessWidget {
  Calculatorbutton({super.key, required this.digit, required this.onClick});
  String digit;
  Function onClick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            onClick(digit);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            digit,
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
