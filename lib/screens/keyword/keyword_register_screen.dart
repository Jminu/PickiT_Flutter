import 'package:flutter/material.dart';
import 'package:pickit_flutter/Keyword.dart';
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
    final userId = Global.getLoggedInUserId();
    if (userId != null) {
      _keywordManager = KeywordManager(userId);
    } else {
      print("로그인된 사용자 ID가 없습니다.");
    }
  }

  Future<void> _registerAndActivateKeyword(String keywordText) async {
    final keyword = Keyword(keywordText);

    setState(() {
      recommendedKeywords.removeWhere((k) => k.keyWord == keywordText);
    });

    if (Global.getLoggedInUserId() != null) {
      await _keywordManager.addKeyword(keyword);
      widget.onKeywordAdded(keyword);
    } else {
      print("사용자 ID를 찾을 수 없습니다.");
    }

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
                    decoration: const InputDecoration(
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
                      _registerAndActivateKeyword(keyword);
                      _controller.clear();
                    }
                  },
                  child: const Text('등록', style: TextStyle(fontSize: 18)),
                  color: Colors.grey[700],
                  textColor: Colors.white,
                  height: 52,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text("🔥요새 키워드 트렌드", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 15),
          Expanded(
            child: recommendedKeywords.isNotEmpty
                ? ListView.builder(
                    itemCount: recommendedKeywords.length,
                    itemBuilder: (context, index) {
                      final keyword = recommendedKeywords[index];
                      return ListTile(
                        title: Text(keyword.keyWord),
                        trailing: MaterialButton(
                          onPressed: () =>
                              _registerAndActivateKeyword(keyword.keyWord),
                          child: const Text('등록'),
                          color: Colors.grey[300],
                        ),
                      );
                    },
                  )
                : const Center(
                    child:
                        Text('추천 키워드가 없습니다.', style: TextStyle(fontSize: 16)),
                  ),
          ),
        ],
      ),
    );
  }
}
