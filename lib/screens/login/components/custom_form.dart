import 'package:flutter/material.dart';
import 'package:pickit_flutter/screens/login/components/custom_text_form_field.dart';
import 'package:pickit_flutter/size.dart';
import 'package:pickit_flutter/AuthManager.dart'; // AuthManager 임포트
import 'package:pickit_flutter/UserManager.dart'; // UserManager 임포트

// 로그인 로직 구현하는 곳
class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>(); // 1. 글로벌 key
  final _userIdController = TextEditingController(); // 2. 사용자 ID 입력 컨트롤러
  final _userPwdController = TextEditingController(); // 3. 비밀번호 입력 컨트롤러

  // 로그인 처리 함수
  Future<void> _login() async {
    String userId = _userIdController.text;
    String userPwd = _userPwdController.text;

    AuthManager am = AuthManager();
    bool isLoggedIn = await am.loginUser(userId, userPwd); // 로그인 시도

    if (isLoggedIn) {
      // 로그인 성공 시 main 화면으로 이동
      Navigator.pushNamed(context, "/home");
    } else {
      // 로그인 실패 시 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 실패. 아이디 또는 비밀번호를 확인하세요.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField("Email",
              controller: _userIdController), // 이메일 입력 필드
          SizedBox(height: mediumGap),
          CustomTextFormField("Password",
              controller: _userPwdController), // 비밀번호 입력 필드
          SizedBox(height: largeGap),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _login(); // 유효성 검사를 통과하면 로그인 시도
              }
            },
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}
