import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("회원가입", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),

              // 아이디 입력
              Text("아이디", style: TextStyle(fontSize: 18, color: Colors.black)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "아이디를 입력하세요",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.55)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.55),
                      minimumSize: Size(80, 30),
                    ),
                    child: Text("중복확인", style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              SizedBox(height: 15),

              // 비밀번호 입력
              Text("비밀번호", style: TextStyle(fontSize: 18, color: Colors.black)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "비밀번호를 입력하세요",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.55)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // 비밀번호 확인 입력
              Text("비밀번호 확인", style: TextStyle(fontSize: 18, color: Colors.black)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.55)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // 닉네임 입력
              Text("닉네임", style: TextStyle(fontSize: 18, color: Colors.black)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "닉네임을 입력하세요",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.55)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(80, 30),
                    ),
                    child: Text("중복확인", style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 45),

              // 회원가입 완료 버튼
              Center(
                child: IconButton(
                  iconSize: 80,
                  icon: Image.asset('assets/images/complete.png'), // 경로를 프로젝트에 맞게 설정하세요.
                  onPressed: () {
                    // 회원가입 완료 동작
                  },
                ),
              ),
              SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
