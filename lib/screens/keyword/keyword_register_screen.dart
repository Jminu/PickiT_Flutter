import 'package:flutter/material.dart';
import '../../models/keyword_data.dart';
import 'package:pickit_flutter/theme.dart';

// 키워드 추천&등록 페이지
class KeywordRegisterScreen extends StatefulWidget {
  final Function(KeywordData) onKeywordAdded;

  KeywordRegisterScreen({required this.onKeywordAdded});

  @override
  _KeywordRegisterScreenState createState() => _KeywordRegisterScreenState();
}

class _KeywordRegisterScreenState extends State<KeywordRegisterScreen> {
  final TextEditingController _controller = TextEditingController();

  void _registerKeyword() {
    String input = _controller.text.trim();

    if (input.isNotEmpty) {
      // 새로운 키워드 추가
      KeywordData newKeyword = KeywordData(title: input, url: null);
      widget.onKeywordAdded(newKeyword);

      // 입력 필드 비우기
      _controller.clear();

      // 스낵바 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('키워드 등록되었습니다.')),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('키워드 추천&등록'),
        centerTitle: true, // 제목을 가운데 정렬
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
                SizedBox(width: 10), // 텍스트 필드와 버튼 사이의 간격
                OutlinedButton(
                  onPressed: _registerKeyword,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.zero, // 모서리 둥근 정도를 0으로 설정하여 네모나게 만듦
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 16.0), // 세로 크기 키우기
                  ),
                  child: Text('등록'),
                )
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
            child: ListView.builder(
              itemCount: exampleKeywords.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(exampleKeywords[index].title),
                  trailing: ElevatedButton(
                    onPressed: () {
                      widget.onKeywordAdded(exampleKeywords[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text('키워드 추가 완료!!'),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.symmetric(
                              horizontal: 120, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      );
                    },
                    child: Text('등록'),
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
