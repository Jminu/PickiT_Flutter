import 'package:flutter/material.dart';
import 'package:pickit_flutter/Keyword.dart';
import 'package:pickit_flutter/KeywordManager.dart';

import 'package:flutter/material.dart';
import 'package:pickit_flutter/Keyword.dart';

import 'package:flutter/material.dart';
import '../../../models/recommended_keywords.dart';
import '../keyword_register_screen.dart';

class KeywordRegisterButton extends StatelessWidget {
  final Function(Keyword) onKeywordAdded;

  const KeywordRegisterButton({Key? key, required this.onKeywordAdded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // KeywordRegisterScreen에 콜백 전달
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KeywordRegisterScreen(
              onKeywordAdded: onKeywordAdded, // 콜백 전달
            ),
          ),
        );
      },
      child: const Text('키워드 추천&등록'),
    );
  }
}
