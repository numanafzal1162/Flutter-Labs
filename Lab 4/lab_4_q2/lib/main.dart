import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/profile.png"),
                  radius: 50,
                ),
              ),
              const Text(
                "Numan Afzal",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Card(
                child: Row(
                  children: const [
                    Padding(padding: EdgeInsets.all(20)),
                    Icon(Icons.phone, color: Colors.grey),
                    SizedBox(width: 20),
                    Text("+92123456789", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: const [
                    Padding(padding: EdgeInsets.all(20)),
                    Icon(
                      Icons.mail,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("numanshykh@gmail.com", style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
