import 'package:flutter/material.dart';
import 'package:pickit_flutter/screens/main_screens.dart';
import 'package:pickit_flutter/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import './AuthManager.dart';
import './KeywordManager.dart';
import './UserManager.dart';
import './Keyword.dart';
import 'package:pickit_flutter/pages/login_page.dart';

void main() async {
  // Firebase 초기화
  // WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  //var authManager = AuthManager();
  // authManager.registerUser("minu", "1234");

  //User user = User("minu", "1234");
  //KeywordManager keywordManager = KeywordManager(user);
  //Keyword keyword = Keyword("삼전", false);
  //keywordManager.addKeyword(keyword);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 1. 테마 설정
      debugShowCheckedModeBanner: false,
      home: MainScreens(),
      theme: theme(),
      /*initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginPage(),
      },*/
    );
  }
}
