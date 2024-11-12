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

  // Future 타입 함수로 설정
  Future<void> initializeUserKeywords(User user) async {
    await user.getUserKeywords();
  }

  @override
  Widget build(BuildContext context) {
    User user = User("minu", "1234");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase'),
        ),
        body: FutureBuilder(
          future: initializeUserKeywords(user),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 로딩 중일 때 로딩 표시를 보여줌
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // 에러 발생 시 에러 메시지 출력
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              // 데이터 로드 완료 후 UI 표시
              return const Center(child: Text('Firebase TEST'));
            }
          },
        ),
      ),
    );
  }
}
