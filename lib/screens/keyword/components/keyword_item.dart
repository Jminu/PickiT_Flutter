import 'package:flutter/material.dart';

class KeywordItem extends StatelessWidget {
  final String keyword; // 키워드 이름
  final bool isRegistered; // 등록 여부
  final VoidCallback onTap; // 클릭 이벤트 처리

  KeywordItem({
    required this.keyword,
    required this.isRegistered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(keyword),
        backgroundColor: isRegistered ? Colors.blueAccent : Colors.grey[300],
        labelStyle:
            TextStyle(color: isRegistered ? Colors.white : Colors.black),
        elevation: 2,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }
}
