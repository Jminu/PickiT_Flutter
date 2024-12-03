import 'package:flutter/material.dart';
import 'package:pickit_flutter/Keyword.dart';
import 'package:pickit_flutter/models/google_trends.dart';
import 'package:pickit_flutter/models/recommended_keywords.dart'; // 추천 키워드 리스트

class KeywordRegisterScreen extends StatefulWidget {
  final Function(Keyword) onKeywordAdded;

  const KeywordRegisterScreen({Key? key, required this.onKeywordAdded})
      : super(key: key);

  @override
  _KeywordRegisterScreenState createState() => _KeywordRegisterScreenState();
}

class _KeywordRegisterScreenState extends State<KeywordRegisterScreen> {
  final TextEditingController _controller = TextEditingController();

  // 키워드 추출 후 추천 리스트에 추가하는 콜백
  void _onKeywordsExtracted(List<Keyword> extractedKeywords) {
    setState(() {
      recommendedKeywords = extractedKeywords;
    });
  }

  Future<void> _registerAndActivateKeyword(String keywordText) async {
    final keyword = Keyword(keywordText);

    // 키워드를 추천 리스트에서 삭제하고 활성화
    setState(() {
      recommendedKeywords.removeWhere((k) => k.keyWord == keywordText);
    });

    widget.onKeywordAdded(keyword);

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
                SizedBox(width: 8),
                MaterialButton(
                  onPressed: () {
                    final keyword = _controller.text.trim();
                    if (keyword.isNotEmpty) {
                      _registerAndActivateKeyword(keyword);
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
          SizedBox(height: 15),
          Text(
            "🔥요새 키워드 트렌드",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 15),
          Expanded(
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
                  return ListTile(
                    title: Text(keyword.keyWord),
                    trailing: MaterialButton(
                      onPressed: () {
                        _registerAndActivateKeyword(keyword.keyWord);
                      },
                      color: Colors.grey[400],
                      textColor: Colors.white,
                      child: const Text('등록'),
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
