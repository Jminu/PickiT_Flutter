import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './AuthManager.dart';
import './KeywordManager.dart';
import './UserManager.dart';
import './Keyword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initializeApp가 처리되는걸 대기

  final User user = User("minu", "1234");
  final userKeywordList = await user.getUserKeywords(); //유저의 키워드 목록 가져오는것을 대기
  print(userKeywordList);

  runApp(const MyApp());
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
