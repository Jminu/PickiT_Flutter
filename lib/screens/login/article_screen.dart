import 'package:flutter/material.dart';
import '../components/article_header.dart';
import '../../components/article_content.dart';
import '../../components/article_floating_button.dart';
import '../models/article.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick iT", style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleHeader(article: article), // 헤더 컴포넌트
              SizedBox(height: 16),
              ArticleContent(content: article.content), // 본문 컴포넌트
              SizedBox(height: 300),
            ],
          ),
        ),
      ),
      floatingActionButton: ArticleFloatingButton(
        onBookmark: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("기사가 북마크되었습니다!")),
          );
        },
        onScrollToTop: () {
          Scrollable.ensureVisible(
            context,
            alignment: 0.0,
            duration: Duration(milliseconds: 300),
          );
        },
        onSummarize: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("AI 기사 요약을 준비 중입니다.")),
          );
        },
      ),
    );
  }
}
