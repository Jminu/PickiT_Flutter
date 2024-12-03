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

  Future<void> _refreshKeywords() async {
    setState(() {
      _initializeKeywords();
    });
  }

  Future<void> _initializeKeywords() async {
    userId = Global.getLoggedInUserId();
    if (userId != null) {
      _keywordManager = KeywordManager(userId!);
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
        onRefresh: _refreshKeywords,
        child: Column(
          children: [
            const SizedBox(height: 5),
            KeywordRegisterButton(
              onKeywordAdded: (newKeyword) {
                setState(() {
                  activeKeywords.add(newKeyword);
                });
              },
            ),
            const SizedBox(height: 15),
            Text("*키워드를 삭제 하려면 오른쪽에서 왼쪽으로 밀어주세요"),
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
                            vertical: 10.0,
                            horizontal: 32.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(1, 3),
                                ),
                              ],
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
