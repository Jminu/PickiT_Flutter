// lib/screens/article_screen.dart

import 'package:flutter/material.dart';
import '../models/article.dart';  // Article 모델 import

class ArticleScreen extends StatefulWidget {
  final Article article;

  ArticleScreen({required this.article});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool isExpanded = false;

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
              Text(
                widget.article.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                widget.article.date,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 16),
              Image.asset(widget.article.imageUrl),
              SizedBox(height: 16),
              Text(
                widget.article.content,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 300),
            ],
          ),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildFloatingActionButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isExpanded) ...[
          FloatingActionButton(
            heroTag: 'bookmark',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("기사가 북마크되었습니다!")));
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.bookmark),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'scroll_to_top',
            onPressed: () {
              Scrollable.ensureVisible(context,
                  alignment: 0.0, duration: Duration(milliseconds: 300));
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.arrow_upward),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'summarize',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("AI 기사 요약을 준비 중입니다.")));
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.remove_red_eye),
          ),
          SizedBox(height: 8),
        ],
        FloatingActionButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          backgroundColor: isExpanded ? Colors.grey : Colors.black,
          child: Icon(isExpanded ? Icons.close : Icons.add),
        ),
      ],
    );
  }
}
