import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class User {
  String userId;
  String userPwd;

  User(this.userId, this.userPwd);

  String getUserId() {
    return this.userId;
  }

  String getUserPwd() {
    return this.userPwd;
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  void setUserPwd(String userPwd) {
    this.userPwd = userPwd;
  }
}

class AuthManager {
  void registerUser(String userId, String userPwd) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");
    var user = User(userId, userPwd);

    ref.set({"userId": user.userId, "userPwd": user.userPwd});
    print("회원가입 성공!");
  }

  void loginUser(String userId, String userPwd) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");

    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      if(data != null && data is Map<Object?, Object?>) {
        final userData = Map<String, dynamic>.from(data);

        if(data["userId"] == userId && data["userPwd"] == userPwd) {
          print("로그인 성공!");
        }
        else {
          print("로그인 실패!");
        }
      }
      else {
        print("DB오류");
      }
    });
  }
}
