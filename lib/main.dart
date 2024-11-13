import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './AuthManager.dart';
import './KeywordManager.dart';
import './UserManager.dart';
import './Keyword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initializeApp가 처리되는걸 대기
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // User 객체 생성과 동시에 Future도 클래스 레벨에서 한 번만 생성
    final User user = User("minu", "1234");
    final Future<List<Map<dynamic, dynamic>>> userKeywordsFuture =
        user.getUserKeywords();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase'),
        ),
        body: FutureBuilder(
          future: userKeywordsFuture,
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
