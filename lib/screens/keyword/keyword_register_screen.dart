import 'package:flutter/material.dart';
import '../../models/Keyword.dart';
import 'package:pickit_flutter/theme.dart';
import '../../keywordmanager.dart';
import '../../global.dart';
import 'package:firebase_database/firebase_database.dart';

class KeywordRegisterScreen extends StatefulWidget {
  @override
  _KeywordRegisterScreenState createState() => _KeywordRegisterScreenState();
}

class _KeywordRegisterScreenState extends State<KeywordRegisterScreen> {
  final TextEditingController _controller = TextEditingController();
  String? userId; // userId 변수 추가

  @override
  void initState() {
    super.initState();
    userId = getLoggedInUserId(); // 로그인된 userId 가져오기
  }

  // Firebase에 키워드 등록
  Future<void> _registerKeyword(String keyword) async {
    if (userId == null) {
      print("User is not logged in.");
      return;
    }

    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/$userId/keywords");

    // 데이터베이스에 새로운 키워드 추가
    await ref.push().set({
      'keyWord': keyword,
      'isActivated': 'true',
    });

    // 등록 완료 후 Snackbar 표시
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$keyword 키워드가 등록되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('키워드 추천&등록'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: '키워드를 등록하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                MaterialButton(
                  onPressed: () {
                    final keyword = _controller.text.trim();
                    if (keyword.isNotEmpty) {
                      _registerKeyword(keyword);
                    }
                  },
                  child: Text(
                    '등록',
                    style: TextStyle(fontSize: 18), // 글자 크기 설정
                  ),
                  color: Colors.grey[700], // 배경색 설정
                  textColor: Colors.white, // 텍스트 색상 설정
                  height: 52, // 세로 크기
                  minWidth: 5, // 가로 크기
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            "🔥요새 키워드 트렌드",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 15),
          // 트렌드 키워드 리스트
          Expanded(
            child: ListView.builder(
              itemCount: recommendKeywords.length, // recommendKeywords 리스트 사용
              itemBuilder: (context, index) {
                final keyword = recommendKeywords[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      keyword.keyWord,
                      style: TextStyle(fontSize: 17),
                    ),
                    trailing: MaterialButton(
                      onPressed: () {
                        _registerKeyword(keyword.keyWord); // 버튼 클릭 시 키워드 등록
                      },
                      color: Colors.grey[400],
                      textColor: Colors.white,
                      minWidth: 50,
                      child: Text(
                        '등록',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
