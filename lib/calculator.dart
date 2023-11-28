import 'package:calculator/renkler.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {

  String input = "";
  String output = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(text){

    if (text == "C") {
      input = "";
      output = "";

    }else if (text == "←") {
      if(input.isNotEmpty){
        input = input.substring(0, input.length-1);
        if(input.isEmpty){input="";}
      }
    } else if (text == "="){  // burada parse metodu ile matamatiksel fonksionları aktif hale getirdik.
      if(input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
      }
    }else {
      input = input + text;
    }
    setState(() {});
  }

  Widget buildButton(text) {

    var ekranBilgisi =
    MediaQuery.of(context); // Ekran bilgisini almak için yazılmalı
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;


    Color buttonColor;
    Color textColor;

    if (text == '+' || text == '-' || text == 'x' || text == "/" || text == "=") {
      buttonColor = butonArtiEksiBoluCarpiEsittirRenk;
      textColor = sayilarRenk;
    } else if (text == 'C' || text == "." || text == "←") {
      buttonColor = butonCNoktaYuzderenk;
      textColor = backroundRenk;
    } else {
      buttonColor = butonRakamlarRenk;
      textColor = sayilarRenk;
    }

    return Column(
        children :  [
          Padding(
            padding: const EdgeInsets.only(left: 9, right: 8, top:12.0, bottom: 1.0),
            child: ElevatedButton(
              onPressed: () {
                buttonPressed(text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: const CircleBorder(),
              ),
              child: SizedBox(
                width: ekranGenisligi/11, height: ekranYuksekligi/11,
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                ),
              ),
            ),
          ),

        ]
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backroundRenk,
      /*appBar: AppBar(
        title: Text('Hesap Makinesi'),
      ),*/
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children : [
                Text(
                  input,
                  style: const TextStyle(fontSize: 54,
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  output,
                  style: TextStyle(fontSize: 42,
                      fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.5),),
                ),
              ]
              ),
            ),
          ),

          const Column(
              children : [
                Padding(
                  padding: EdgeInsets.only(bottom:32),
                  child:   Divider(), // Aradaki line için eklendi.
                ),
              ]
          ),
          Row(
            children: <Widget>[
              buildButton('C'),
              buildButton('.'),
              buildButton('←'),
              buildButton('/'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('x'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('-'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('+'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('('),
              buildButton('0'),
              buildButton(")"),
              buildButton('='),
            ],
          ),
        ],
      ),
    );
  }
}
