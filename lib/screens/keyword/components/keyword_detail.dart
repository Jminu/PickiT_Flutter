import 'package:flutter/material.dart';
import '../../../models/new_keyword.dart'; // 모델 파일 import

class KeywordDetailScreen extends StatelessWidget {
  final String keyword;

  KeywordDetailScreen({required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$keyword 관련 뉴스')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: newsData.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(newsData[index].imageUrl),
              title: Text(newsData[index].title),
              subtitle: Text(newsData[index].category),
              onTap: () {
                // 아직 구현되지 않은 페이지 이동 기능
                // Navigator.push(...);
              },
            );
          },
        ),
      ),
    );
  }
}
