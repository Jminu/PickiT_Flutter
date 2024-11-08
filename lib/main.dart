import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './AuthManager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    var authManager = AuthManager();
    authManager.registerUser("s9430939", "1234");

    authManager.loginUser("s9430939", "1234");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FireBase'),
        ),
        body: const Center(
          child: Text('Firebase TEST'),
        ),
      ),
    );
  }
}
