import 'package:flutter/material.dart';
import 'package:pickit_flutter/size.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/logo.png",
          height: 100,
          width: 500,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 50), // 이미지와 텍스트 사이 간격을 10으로 설정 (조정 가능)
        Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
