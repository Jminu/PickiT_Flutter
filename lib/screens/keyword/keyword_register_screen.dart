import 'package:flutter/material.dart';
import 'package:pickit_flutter/Keyword.dart';
import 'package:pickit_flutter/models/google_trends.dart';
import 'package:pickit_flutter/models/recommended_keywords.dart';
import 'package:pickit_flutter/global.dart';
import 'package:pickit_flutter/KeywordManager.dart';

class KeywordRegisterScreen extends StatefulWidget {
  final Function(Keyword) onKeywordAdded;

  const KeywordRegisterScreen({Key? key, required this.onKeywordAdded})
      : super(key: key);

  @override
  _KeywordRegisterScreenState createState() => _KeywordRegisterScreenState();
}

class _KeywordRegisterScreenState extends State<KeywordRegisterScreen> {
  final TextEditingController _controller = TextEditingController();
  late KeywordManager _keywordManager;

  @override
  void initState() {
    super.initState();
    final userId = Global.getLoggedInUserId(); // 사용자 ID 가져오기
    if (userId != null) {
      _keywordManager = KeywordManager(userId);
    } else {
      print("로그인된 사용자 ID가 없습니다.");
    }
  }

  void _onKeywordsExtracted(List<Keyword> extractedKeywords) {
    setState(() {
      recommendedKeywords = extractedKeywords;
    });
  }

  Future<void> _registerAndActivateKeyword(String keywordText) async {
    final keyword = Keyword(keywordText);

    // 추천 리스트에서 삭제
    setState(() {
      recommendedKeywords.removeWhere((k) => k.keyWord == keywordText);
    });

    // 키워드를 Firebase에 저장
    if (Global.getLoggedInUserId() != null) {
      await _keywordManager.addKeyword(keyword); // 키워드 추가
    } else {
      print("사용자 ID를 찾을 수 없습니다.");
    }

    // 콜백으로 추가된 키워드 처리
    widget.onKeywordAdded(keyword);

    // 성공 메시지 출력
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('키워드가 등록되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('키워드 추천&등록'),
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
                const SizedBox(width: 8),
                MaterialButton(
                  onPressed: () {
                    final keyword = _controller.text.trim();
                    if (keyword.isNotEmpty) {
                      _registerAndActivateKeyword(keyword); // 등록 함수 호출
                      _controller.clear();
                    }
                  },
                  child: const Text(
                    '등록',
                    style: TextStyle(fontSize: 18),
                  ),
                  color: Colors.grey[700],
                  textColor: Colors.white,
                  height: 52,
                  minWidth: 5,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "🔥요새 키워드 트렌드",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 3,
            child: GoogleTrendsScreen(
              onKeywordsExtracted: _onKeywordsExtracted,
            ),
          ),
          if (recommendedKeywords.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: recommendedKeywords.length,
                itemBuilder: (context, index) {
                  final keyword = recommendedKeywords[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 26.0,
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
                            offset: const Offset(1, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            keyword.keyWord,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        trailing: MaterialButton(
                          onPressed: () {
                            _registerAndActivateKeyword(keyword.keyWord);
                          },
                          color: Colors.grey.withOpacity(0.3),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text('등록'),
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
