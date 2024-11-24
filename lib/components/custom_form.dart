import 'package:flutter/material.dart';
import 'package:pickit_flutter/components/custom_text_form_field.dart';
import 'package:pickit_flutter/size.dart';

class CustomForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // 1. 글로벌 key

  CustomForm({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Form(
      // 2. 글로벌 key를 Form 태그에 연결하여 해당 key로 Form의 상태를 관리할 수 있다.
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField("Email"),
          SizedBox(height: mediumGap),
          CustomTextFormField("Password"),
          SizedBox(height: largeGap),
          // 3. Login 버튼
          TextButton(
            onPressed: () {
              // 4. 유효성 검사
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, "/home");
              }
            },
            child: Text("Login"),
          ),
          SizedBox(height: mediumGap), // 간격 추가
          // 4. Register 버튼 추가
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/register"); // 회원가입 페이지로 이동
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
