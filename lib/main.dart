import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './AuthManager.dart';
import './KeywordManager.dart';
import './UserManager.dart';
import './Keyword.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var authManager = AuthManager();
    authManager.registerUser("minu", "1234");

    User user = User("minu", "1234");
    KeywordManager keywordmanager = KeywordManager(user);
    Keyword keyword = Keyword("삼전", false);
    keywordmanager.addKeyword(keyword);

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
