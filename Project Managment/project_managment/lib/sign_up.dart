import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpHomePage extends StatefulWidget {
  const SignUpHomePage({Key? key}) : super(key: key);

  @override
  State<SignUpHomePage> createState() => _SignUpHomePageState();
}

class _SignUpHomePageState extends State<SignUpHomePage> {
  String _username = " ";
  String _pass = " ";

  void ShowSnackBar(String text, Color color, BuildContext ctx) {
    final snack = SnackBar(
      content: Text(text),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(ctx).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SignUp"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onChanged: (val) {
                    _username = val;
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (val) {
                    _pass = val;
                  },
                ),
                TextButton(
                    onPressed: () async {
                      try {
                        print(_username);
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _username,
                          password: _pass,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          //print('The password provided is too weak.');
                          ShowSnackBar("The password provided is too weak.",
                              Colors.red, context);
                        } else if (e.code == 'email-already-in-use') {
                          //print('The account already exists for that email.');
                          ShowSnackBar(
                              "The account already exists for that email.",
                              Colors.red,
                              context);
                        }
                      } catch (e) {
                        ShowSnackBar(
                            "Something Went Wrong.", Colors.red, context);
                      }
                    },
                    child: Text("Sign Up")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
