import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Messaging App'),
      ),
      body: MessagingHomePage(),
    ),
  ));
}

class MessagingHomePage extends StatefulWidget {
  const MessagingHomePage({Key? key}) : super(key: key);

  @override
  State<MessagingHomePage> createState() => _MessagingHomePageState();
}

class _MessagingHomePageState extends State<MessagingHomePage> {
  String msg = "";
  String messages = "Nothing";
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    String allMessages = "";
    //reading data
    final collectionRef = db.collection("message");
    collectionRef.orderBy('timestamp').snapshots().listen(
      (event) {
        for (var doc in event.docs) {
          allMessages = allMessages + " ; " + doc.data()["msg"];
        }
        setState(() {
          messages = allMessages;
        });
      },
      onError: (error) => print("Listen failed: $error"),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(messages),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Write Message',
                ),
                onChanged: (value) {
                  msg = value;
                },
              ),
            ),
            TextButton(
              onPressed: () {
                final msgToSave = <String, dynamic>{
                  'msg': msg,
                  'timestamp': DateTime.now().millisecondsSinceEpoch
                };
                //inserting data
                db.collection("message").add(msgToSave).then(
                    (DocumentReference doc) =>
                        print("Added Data with ID: ${doc.id}"));
                String allMessages = "";
                //reading data
                db
                    .collection("message")
                    .orderBy('timestamp')
                    .snapshots()
                    .listen(
                  (event) {
                    for (var doc in event.docs) {
                      allMessages = allMessages + " ; " + doc.data()["msg"];
                    }
                    setState(() {
                      messages = allMessages;
                    });
                  },
                  onError: (error) => print("Listen failed: $error"),
                );
              },
              child: const Icon(Icons.send),
            )
          ],
        )
      ],
    );
  }
}
