import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pickit_flutter/screens/main_screens.dart';
import 'package:pickit_flutter/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import './AuthManager.dart';
import './KeywordManager.dart';
import './UserManager.dart';
import './Keyword.dart';
import '/global.dart';
import './Controller/GetFilteredFeeds.dart';
import 'package:pickit_flutter/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initializeApp가 처리되는걸 대기

  AuthManager am = AuthManager();
  User user = User("minu", "1234");
  bool isLoggedIn = await am.loginUser(user.userId, user.userPwd); //로그인


  runApp(const MyApp());

  /**
   * 이 부분이 실행되면, 뉴스기사 긁어옵니다.
   * 모두가 사용하면 사용량이 많아져서 요금을 내야합니다. 따라서 제가 깃헙에 올릴때는 이부분 주석처리하고
   * 올리겠습니다.
   */
  //앱 실행 후 2초마다 fetchUserId 호출
  // Timer.periodic(Duration(seconds: 10), (timer) {
  //   getFilteredFeeds();
  // });
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
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginPage(),
      },
    );
  }
}
