import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pickit_flutter/screens/home/home_screen.dart';
import 'package:pickit_flutter/screens/login/login_screen.dart';
import 'package:pickit_flutter/screens/login/register_screen.dart';
import 'package:pickit_flutter/screens/main_screens.dart';
import 'package:pickit_flutter/screens/myaccount/my_scrapscreen.dart';
import 'package:pickit_flutter/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import './AuthManager.dart';
import './KeywordManager.dart';
import './UserManager.dart';
import './Keyword.dart';
import '/global.dart';
import './Controller/GetFilteredFeeds.dart';
import './Controller/GetSummary.dart';
import './ShowDB.dart';

import 'models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(); //initializeApp가 처리되는걸 대기
    print("Firebase 초기화 완료");
  } catch (e) {
    print("Firebase 초기화 실패");
  }

  //showDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login", // 초기 화면 경로 설정
      theme: theme(),
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(), // 회원가입 페이지
        "/home": (context) => const MainScreens(), // MainScreens로 연결
      },
    );
  }
}
