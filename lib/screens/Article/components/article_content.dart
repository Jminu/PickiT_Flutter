import 'package:flutter/material.dart';

class ArticleContent extends StatelessWidget {
  final String content;

  const ArticleContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
