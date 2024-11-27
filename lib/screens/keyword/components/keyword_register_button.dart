import 'package:flutter/material.dart';
import '../../../models/keyword_data.dart';
import '../keyword_register_screen.dart';

// 키워드 버튼 관련
class KeywordRegisterButton extends StatelessWidget {
  final Function(KeywordData) onKeywordAdded;

  const KeywordRegisterButton({required this.onKeywordAdded, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                KeywordRegisterScreen(onKeywordAdded: onKeywordAdded),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: 14.0, horizontal: 30.0), // 상하, 좌우 패딩을 늘려서 크기 증가
      ),
      child: const Text('키워드 추천&등록'),
    );
  }
}
