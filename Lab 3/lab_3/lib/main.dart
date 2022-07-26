import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("BSIT"),
        ),
        body: Column(
          children: [
            contantwidget(
              Icon(Icons.add),
              Text("First Argument"),
            ),
            contantwidget(
              Icon(Icons.abc_rounded),
              Text("Second Argument"),
            ),
          ],
        ),
      ),
    ),
  );
}

class contantwidget extends StatelessWidget {
//data memebers
  final Icon contacticon;
  final Text contacttext;
//constructor
  contantwidget(this.contacticon, this.contacttext);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        contacticon,
        contacttext,
      ],
    );
  }
}
