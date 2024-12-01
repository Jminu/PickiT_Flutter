import 'package:flutter/material.dart';
import 'package:pickit_flutter/components/logo/logo.dart';
import 'package:pickit_flutter/screens/login/components/custom_form2.dart';
import 'package:pickit_flutter/size.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "회원가입",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 상단 여백
            SizedBox(height: largeGap),
            Logo("회원가입"), // 로고
            SizedBox(height: largeGap), // 간격 추가
            // 커스텀 폼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child:
                  CustomForm2(), // CustomForm2에서 Register 버튼으로 ProductPage로 이동
            ),
            // 추가 여백
            SizedBox(height: largeGap),
          ],
        ),
      ),
    );
  }
}
