import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../keywordmanager.dart';
import '../../models/keyword.dart';
import '../../AuthManager.dart';
import 'package:pickit_flutter/global.dart';
import "./keyword_register_screen.dart";
import './components/keyword_register_button.dart';
import './components/swipe_to_delete.dart';

class KeywordScreen extends StatefulWidget {
  @override
  _KeywordScreenState createState() => _KeywordScreenState();
}

class _KeywordScreenState extends State<KeywordScreen> {
  late KeywordManager _keywordManager;
  List<Keyword> activeKeywords = [];
  String? userId;
  late DatabaseReference _keywordsRef;

  @override
  void initState() {
    super.initState();
    // 로그인된 유저 ID 가져오기
    userId = getLoggedInUserId();
    if (userId != null) {
      _keywordManager = KeywordManager(userId: userId!);
      _keywordsRef = FirebaseDatabase.instance.ref("users/$userId/keywords");
      _loadActiveKeywords();
      _listenForKeywordChanges();
    }
  }

  // 활성화된 키워드 로드
  Future<void> _loadActiveKeywords() async {
    final snapshot = await _keywordsRef.get();

    if (snapshot.exists) {
      List<Keyword> keywords = snapshot.children
          .map((child) {
            // 데이터 변환
            String keyWord = child.child("keyWord").value as String;
            bool isActivated = child.child("isActivated").value == "true";
            return Keyword(keyWord, isActivated: isActivated);
          })
          .where((keyword) => keyword.isActivated) // 활성화된 키워드 필터링
          .toList();

      setState(() {
        // 중복된 키워드는 추가하지 않음
        activeKeywords = activeKeywords
                .where((existingKeyword) => !keywords.any(
                    (keyword) => keyword.keyWord == existingKeyword.keyWord))
                .toList() +
            keywords;
      });
    } else {
      setState(() {
        activeKeywords = [];
      });
      print("활성화된 키워드가 없습니다.");
    }
  }

  // 키워드 변경 사항 실시간 반영
  void _listenForKeywordChanges() {
    _keywordsRef.onChildAdded.listen((event) {
      final keyword = Keyword(
        event.snapshot.child("keyWord").value as String,
        isActivated: event.snapshot.child("isActivated").value == "true",
      );
      if (keyword.isActivated &&
          !activeKeywords.any((k) => k.keyWord == keyword.keyWord)) {
        setState(() {
          activeKeywords.add(keyword);
        });
      }
    });

    _keywordsRef.onChildChanged.listen((event) {
      final updatedKeyword = Keyword(
        event.snapshot.child("keyWord").value as String,
        isActivated: event.snapshot.child("isActivated").value == "true",
      );
      setState(() {
        activeKeywords = activeKeywords.map((keyword) {
          return keyword.keyWord == updatedKeyword.keyWord
              ? updatedKeyword
              : keyword;
        }).toList();
      });
    });

    _keywordsRef.onChildRemoved.listen((event) {
      final removedKeyword = Keyword(
        event.snapshot.child("keyWord").value as String,
        isActivated: event.snapshot.child("isActivated").value == "true",
      );
      setState(() {
        activeKeywords.removeWhere(
            (keyword) => keyword.keyWord == removedKeyword.keyWord);
      });
    });
  }

  // 키워드 삭제
  Future<void> _removeKeyword(Keyword keyword) async {
    await _keywordManager.removeKeyword(keyword);
    setState(() {
      activeKeywords.remove(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('활성화된 키워드'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10), // 상단 여백 추가
          KeywordRegisterButton(), // 버튼 추가
          const SizedBox(height: 20), // 버튼 아래 여백 추가
          Expanded(
            // 키워드 리스트 확장
            child: activeKeywords.isEmpty
                ? const Center(
                    child: Text("활성화된 키워드가 없습니다."),
                  )
                : ListView.builder(
                    itemCount: activeKeywords.length,
                    itemBuilder: (context, index) {
                      final keyword = activeKeywords[index];
                      return SwipeToDelete(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36.0, vertical: 3.0),
                          child: Card(
                            color: Colors.white.withOpacity(0.8),
                            elevation: 3, // 카드에 그림자 추가
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(18.0), // 둥근 모서리
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(3.0),
                              title: Text(
                                "   " + keyword.keyWord,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_back_ios, // 삭제 아이콘
                              ),
                            ),
                          ),
                        ),
                        onDelete: () => _removeKeyword(keyword),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
