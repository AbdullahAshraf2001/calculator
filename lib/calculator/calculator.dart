import 'package:calculator/calculator/calculatorButton.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  static String routeName = "calculator";

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String resultText = "0";
  String lhs = "";
  String operator = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text("")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      lhs + operator,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      resultText,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Calculatorbutton(digit: "AC", onClick: onRemoveClick),
                  Calculatorbutton(digit: "<-", onClick: onRemoveClick),
                  Calculatorbutton(digit: "%", onClick: onOperatorClick),
                  Calculatorbutton(digit: "/", onClick: onOperatorClick),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Calculatorbutton(digit: "7", onClick: onDigitClick),
                  Calculatorbutton(digit: "8", onClick: onDigitClick),
                  Calculatorbutton(digit: "9", onClick: onDigitClick),
                  Calculatorbutton(digit: "x", onClick: onOperatorClick),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Calculatorbutton(digit: "4", onClick: onDigitClick),
                  Calculatorbutton(digit: "5", onClick: onDigitClick),
                  Calculatorbutton(digit: "6", onClick: onDigitClick),
                  Calculatorbutton(digit: "-", onClick: onOperatorClick),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Calculatorbutton(digit: "1", onClick: onDigitClick),
                  Calculatorbutton(digit: "2", onClick: onDigitClick),
                  Calculatorbutton(digit: "3", onClick: onDigitClick),
                  Calculatorbutton(digit: "+", onClick: onOperatorClick),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          onDigitClick("0");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "0",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          onDigitClick(".");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          ".",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            123,
                            0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          onEqualClick("=");
                        },
                        child: Text(
                          "=",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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

  onRemoveClick(String clickedButton) {
    if (clickedButton == "AC") {
      resultText = "0";
      lhs = "";
      operator = "";
    } else if (clickedButton == "<-") {
      if (resultText.isNotEmpty && resultText != "0") {
        resultText = resultText.substring(0, resultText.length - 1);
        if (resultText.isEmpty) {
          resultText = "0";
        }
      }
    }
    setState(() {});
  }

  onEqualClick(_) {
    if (lhs.isEmpty || operator.isEmpty || resultText.isEmpty) {
      return;
    }
    resultText = calcualate(lhs, operator, resultText);
    lhs = "";
    operator = "";
    setState(() {});
  }

  onDigitClick(String digit) {
    if (digit == "." && resultText.contains(".")) {
      return;
    }
    if (resultText == "0" && digit != ".") {
      resultText = "";
    }
    resultText += digit;
    setState(() {});
  }

  onOperatorClick(String clickedOperator) {
    if (resultText.isEmpty && lhs.isEmpty) {
      return;
    }
    if (lhs.isNotEmpty && resultText.isEmpty) {
      operator = clickedOperator;
      setState(() {});
      return;
    }
    if (operator.isEmpty) {
      lhs = resultText;
      setState(() {});
    } else {
      lhs = calcualate(lhs, operator, resultText);
    }
    operator = clickedOperator;
    resultText = "";
    setState(() {});
  }

  String calcualate(String lhs, String operator, String rhs) {
    if (operator == "+") {
      return "${double.parse(lhs) + double.parse(rhs)}";
    } else if (operator == "-") {
      return "${double.parse(lhs) - double.parse(rhs)}";
    } else if (operator == "x") {
      return "${double.parse(lhs) * double.parse(rhs)}";
    } else if (operator == "%") {
      return "${double.parse(lhs) % double.parse(rhs)}";
    } else {
      return "${double.parse(lhs) / double.parse(rhs)}";
    }
  }
}
