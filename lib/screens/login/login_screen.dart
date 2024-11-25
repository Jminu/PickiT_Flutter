import 'package:flutter/material.dart';
import 'package:pickit_flutter/components/logo.dart';
import 'package:pickit_flutter/screens/login/components/custom_form.dart';
import 'package:pickit_flutter/size.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.2),
                Logo("Login"),
                SizedBox(height: largeGap),
                CustomForm(),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}