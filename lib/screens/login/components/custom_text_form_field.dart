import 'package:flutter/material.dart';
import 'package:pickit_flutter/size.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final TextEditingController controller; // 1. 컨트롤러 추가

  const CustomTextFormField(this.text, {Key? key, required this.controller})
      : super(key: key); // 2. 생성자에서 컨트롤러 받기

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: smallGap),
        TextFormField(
          controller: controller, // 3. 컨트롤러를 텍스트 폼 필드에 연결
          validator: (value) =>
              value!.isEmpty ? "Please enter some text" : null,
          obscureText: text == "Password" ? true : false,

          //디자인부분
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
