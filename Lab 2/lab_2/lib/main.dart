import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text("BSIT"),
        ),
        body: Container(
          child: Column(
            children: [
              Row(children: [
                Text("BSAI"),
                Icon(Icons.add),
              ]),
              Text("BSSE")
            ],
          ),
        ),
      ),
    ),
  );
}
