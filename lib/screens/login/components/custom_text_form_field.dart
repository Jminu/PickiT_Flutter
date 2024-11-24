import 'package:flutter/material.dart';
import 'package:pickit_flutter/size.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final TextEditingController controller; // 컨트롤러
  final bool obscureText; // 비밀번호 숨김 여부 추가

  const CustomTextFormField(
      this.text, {
        Key? key,
        required this.controller,
        this.obscureText = false, // 기본값 false로 설정
      }) : super(key: key); // 생성자에서 컨트롤러와 obscureText 받기

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: smallGap),
        TextFormField(
          controller: controller, // 컨트롤러 연결
          validator: (value) =>
          value!.isEmpty ? "Please enter some text" : null,
          obscureText: obscureText, // obscureText 사용 (비밀번호 숨김)
          decoration: InputDecoration(
            hintText: "Enter $text",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
