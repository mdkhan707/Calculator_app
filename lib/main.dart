import 'package:calculator_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: calculator_app()));
}

class calculator_app extends StatefulWidget {
  const calculator_app({super.key});

  @override
  State<calculator_app> createState() => _calculator_appState();
}

class _calculator_appState extends State<calculator_app> {
  double firstNum = 0.0;
  double SecondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideinput = false;
  var outputsize = 34.0;

  onButtonclick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputsize = 52;
      }
    } else {
      input = input + value;
      hideinput = false;
      outputsize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hideinput ? "" : input,
                        style:
                            const TextStyle(fontSize: 45, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        output,
                        style: TextStyle(
                            fontSize: outputsize,
                            color: Colors.white.withOpacity(0.7)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
            ),
            Row(
              children: [
                button(
                    text: "AC",
                    buttonbgcolor: operatorcolor,
                    tcolor: Colors.orange),
                button(text: "<", buttonbgcolor: operatorcolor),
                button(text: "+/-", buttonbgcolor: Colors.transparent),
                button(
                    text: "/",
                    buttonbgcolor: operatorcolor,
                    tcolor: Colors.orange),
              ],
            ),
            Row(
              children: [
                button(text: "7"),
                button(text: "8"),
                button(text: "9", buttonbgcolor: Colors.transparent),
                button(text: "x", tcolor: Colors.orange),
              ],
            ),
            Row(
              children: [
                button(text: "4"),
                button(text: "5"),
                button(text: "6", buttonbgcolor: Colors.transparent),
                button(text: "-", tcolor: Colors.orange),
              ],
            ),
            Row(
              children: [
                button(text: "1"),
                button(text: "2"),
                button(text: "3", buttonbgcolor: Colors.transparent),
                button(
                    text: "+",
                    tcolor: Colors.orange,
                    buttonbgcolor: operatorcolor),
              ],
            ),
            Row(
              children: [
                button(text: "%"),
                button(text: "0"),
                button(text: ".", buttonbgcolor: Colors.transparent),
                button(
                    text: "=", buttonbgcolor: Color.fromARGB(255, 241, 66, 66)),
              ],
            )
          ],
        ));
  }

  Widget button({text, tcolor = Colors.white, buttonbgcolor = buttoncolor}) =>
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(22),
              primary: buttoncolor,
            ),
            onPressed: (() => onButtonclick(text)),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: tcolor),
            ),
          ),
        ),
      );
}
