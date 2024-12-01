import 'package:flutter/material.dart';

import '../../../models/article.dart';

class ArticleHeader extends StatelessWidget {
  final Article article;

  const ArticleHeader({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          article.date,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 16),
        Image.asset(article.imageUrl),
      ],
    );
  }
}
