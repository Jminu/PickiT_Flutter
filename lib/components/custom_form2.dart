import 'package:flutter/material.dart';
import 'package:pickit_flutter/components/custom_text_form_field.dart';
import 'package:pickit_flutter/size.dart';

class CustomForm2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // 글로벌 key

  CustomForm2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField("Email"),
          SizedBox(height: mediumGap),
          CustomTextFormField("Password"),
          SizedBox(height: mediumGap),
          CustomTextFormField("Confirm password"), // 비밀번호 확인
          SizedBox(height: largeGap),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // ProductPage로 이동
                Navigator.pushNamed(context, "/home");
              }
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
