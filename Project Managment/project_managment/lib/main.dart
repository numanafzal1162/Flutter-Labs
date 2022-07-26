import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() {
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // bool loggedIn = false;
  // final user = FirebaseAuth.instance.currentUser;
  // if (user != null) {
  //   loggedIn = true;

  runApp(LoginPage());
  // runApp(loggedIn ? const HomePage() : const LoginPage());
}
