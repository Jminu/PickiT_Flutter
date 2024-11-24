import 'package:flutter/material.dart';
import 'package:pickit_flutter/size.dart';
import 'package:pickit_flutter/AuthManager.dart';

import '../screens/login/components/custom_text_form_field.dart';

class CustomForm2 extends StatefulWidget {
  const CustomForm2({Key? key}) : super(key: key);

  @override
  _CustomForm2State createState() => _CustomForm2State();
}

class _CustomForm2State extends State<CustomForm2> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _register() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("비밀번호가 일치하지 않습니다.")),
      );
      return;
    }

    AuthManager am = AuthManager();
    bool isRegistered = await am.registerUser(email, password);

    if (isRegistered) {
      Navigator.pushNamed(context, "/login");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("회원가입이 완료되었습니다. 로그인해주세요!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("회원가입 실패. 다시 시도해주세요.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            "Email",
            controller: _emailController,
          ),
          SizedBox(height: mediumGap),
          CustomTextFormField(
            "Password",
            controller: _passwordController,
            obscureText: true, // 비밀번호 숨김
          ),
          SizedBox(height: mediumGap),
          CustomTextFormField(
            "Confirm Password",
            controller: _confirmPasswordController,
            obscureText: true, // 비밀번호 확인 숨김
          ),
          SizedBox(height: largeGap),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _register();
              }
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
