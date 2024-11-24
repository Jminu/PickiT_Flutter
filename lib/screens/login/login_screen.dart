import 'package:flutter/material.dart';
import 'package:pickit_flutter/components/logo.dart';
import 'package:pickit_flutter/screens/login/components/custom_form.dart';
import 'package:pickit_flutter/size.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Spacer(flex: 1), // 로고가 상단에 위치하도록 설정
            // Spacer로 위쪽 여백을 추가하여 로고가 상단에 위치
            Logo("Login"),
            SizedBox(height: largeGap), // 로고와 로그인 폼 사이의 간격
            CustomForm(),
            Spacer(flex: 3), // 로그인 폼 아래쪽 여백을 추가하여 균형 잡기
          ],
        ),
      ),
    );
  }
}
