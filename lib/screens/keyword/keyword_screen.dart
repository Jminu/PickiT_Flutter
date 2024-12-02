import 'package:flutter/material.dart';
import 'package:pickit_flutter/KeywordManager.dart';
import '../../Keyword.dart';
import 'package:pickit_flutter/global.dart';
import 'components/swipe_to_delete.dart';
import 'components/keyword_register_button.dart';

class KeywordScreen extends StatefulWidget {
  @override
  _KeywordScreenState createState() => _KeywordScreenState();
}

class _KeywordScreenState extends State<KeywordScreen> {
  String? userId;
  late KeywordManager _keywordManager;
  List<Keyword> activeKeywords = [];

  @override
  void initState() {
    super.initState();
    _initializeKeywords();
  }

  //초기 로그인 될때 데이터 최신화
  // 데이터 새로 고침 함수
  Future<void> _refreshKeywords() async {
    setState(() {
      _initializeKeywords();  // 키워드를 다시 로드
    });
  }

  Future<void> _initializeKeywords() async {
    userId = Global.getLoggedInUserId();
    if (userId != null) {
      _keywordManager = KeywordManager(userId!);
      // Fetching keywords using KeywordManager
      List<Keyword> keywords = await _keywordManager.getMyKeywords();
      setState(() {
        activeKeywords = keywords;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('키워드 관리'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshKeywords,  // 새로 고침을 위한 함수 호출
        child: Column(
          children: [
            const SizedBox(height: 15),
            KeywordRegisterButton(
              onKeywordAdded: (Keyword newKeyword) {
                setState(() {
                  activeKeywords.add(newKeyword);
                });
              },
              keywordManager: _keywordManager,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: activeKeywords.isEmpty
                  ? const Center(
                child: Text(
                  "등록된 키워드가 없습니다.",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: activeKeywords.length,
                itemBuilder: (context, index) {
                  final keyword = activeKeywords[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: SwipeToDelete(
                      onDelete: () async {
                        await _keywordManager.removeKeyword(keyword);
                        setState(() {
                          activeKeywords.removeAt(index);
                        });
                      },
                      child: ListTile(
                        title: Text(
                          keyword.keyWord,
                          style: const TextStyle(fontSize: 18),
                        ),
                        trailing: const Icon(Icons.chevron_left),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
