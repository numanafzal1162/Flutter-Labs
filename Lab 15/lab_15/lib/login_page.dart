import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: LoginDesign(),
      ),
    );
  }
}

class LoginDesign extends StatelessWidget {
  LoginDesign({Key? key}) : super(key: key);

  String email = "";
  String pass = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              RegExp regExp =
                  RegExp(r'[a-zA-Z0-9]{3,20}@student\.ntu\.edu\.pk');
              var textNotNull = text ?? "";
              if (textNotNull.isEmpty) {
                return 'Email is required';
              } else if (!regExp.hasMatch(textNotNull)) {
                return 'Email is not valid';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter your NTU email'),
            onChanged: (text) {
              email = text;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autofocus: true,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              RegExp regExp =
                  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
              var textNotNull = text ?? "";
              if (textNotNull.isEmpty) {
                return 'Password is required';
              } else if (!regExp.hasMatch(textNotNull)) {
                return 'Password is not valid';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your password'),
            onChanged: (text) {
              pass = text;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () async {
              try {
                final credential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: email, password: pass);
                final userEmail = credential.user!.email ?? "";
                Flushbar(
                  backgroundColor: Colors.green,
                  titleText: const Text('Login Successfull'),
                  messageText: Text('Logged in as: ' + userEmail),
                  duration: const Duration(seconds: 3),
                ).show(context);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('user not found');
                  Flushbar(
                    backgroundColor: Colors.red,
                    titleText: const Text('Login Failed'),
                    messageText: const Text('User not found'),
                    duration: const Duration(seconds: 3),
                  ).show(context);
                } else if (e.code == 'wrong-password') {
                  print('wrong password');
                  Flushbar(
                    backgroundColor: Colors.red,
                    titleText: const Text('Login Failed'),
                    messageText: const Text('Password is incorrect'),
                    duration: const Duration(seconds: 3),
                  ).show(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
