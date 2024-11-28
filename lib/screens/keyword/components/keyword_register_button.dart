import 'package:flutter/material.dart';
import '../../../models/keyword.dart';

import '../keyword_register_screen.dart';

// 키워드 버튼 관련
class KeywordRegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KeywordRegisterScreen(),
          ),
        );
      },
      child: const Text('키워드 추천&등록'),
    );
  }
}
