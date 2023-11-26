import 'package:calculator/renkler.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {

  String output = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String text){

    if (text == "C"){
      output = "";
      num1 = 0;
      num2 = 0;
      operand = "";

    }else if (text == "+" || text == "-" || text == "x" || text == "/" || text == "%" ) {
      num1 = double.parse(output);
      operand = text;
      output = "";
    } else if (text == "←") {
      setState(() {
        output = output.substring(0, output.length-1);
        if(output.isEmpty){output="";}
      });
    }else if (text == "(" || text == ")"){
      setState(() {
        output += text;
      });
    }
    else if (text == "="){
      num2 = double.parse(output);
      if(operand=="+"){
        output = (num1+num2).toString();
      }
      if(operand=="-"){
        output = (num1-num2).toString();
      }
      if(operand=="x"){
        output = (num1*num2).toString();
      }
      if(operand=="/"){
        output = (num1/num2).toString();
      }
      num1 =0;
      num2 = 0;
      operand ="";
    }else {
      output += text;
    }
    setState(() {});
  }

  Widget buildButton(String text) {

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

    return Padding(
      padding: const EdgeInsets.only(left: 1.5, right: 1.5, top:12.0, bottom: 1.0),
      child: Expanded(
        child: ElevatedButton(
          onPressed: () {
            buttonPressed(text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: const CircleBorder(),
          ),
          child: SizedBox(
            width: ekranGenisligi/8, height: ekranYuksekligi/8,
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
        children: <Widget>[
          Expanded(
              child: Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(top:40, right:5),
                child: Text(
                   output,
                  style: const TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          const Padding(
            padding: EdgeInsets.only(bottom:32),
            child:  Expanded(child: Divider(), // Aradaki line için eklendi.
            ),
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
