import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(dice());
}

class dice extends StatefulWidget {
  const dice({Key? key}) : super(key: key);
  @override
  State<dice> createState() => _diceState();
}

class _diceState extends State<dice> {
  double dice = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Row(children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          dice = Random().nextInt(6) + 1;
                        },
                      );
                    },
                    child: Image.asset("images/dice$dice.png"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          dice = Random().nextInt(6) + 1;
                        },
                      );
                    },
                    child: Image.asset("images/dice$dice.png"),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
