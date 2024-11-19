import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './AuthManager.dart';
import './KeywordManager.dart';
import './UserManager.dart';
import './Keyword.dart';
import '/global.dart';
import './Controller/GetFilteredFeeds.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initializeApp가 처리되는걸 대기

  AuthManager am = AuthManager();
  User user = User("minu", "1234");
  am.loginUser(user.userId, user.userPwd); //로그인

  Keyword keyword = Keyword("삼성", true);
  // Keyword keyword2 = Keyword("엘지", true);
  // Keyword keyword3 = Keyword("하이닉스", true);
  //
  KeywordManager km = KeywordManager(user);
  //km.addKeyword(keyword);
  // km.addKeyword(keyword2);
  // km.addKeyword(keyword3);

  runApp(const MyApp());

  //앱 실행 후 2초마다 fetchUserId 호출
  Timer.periodic(Duration(seconds: 10), (timer) {
    getFilteredFeeds();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase'),
        ),
        body: const Center(
          child: Text('Firebase TEST'), // 기본 텍스트만 표시
        ),
      ),
    );
  }
}
