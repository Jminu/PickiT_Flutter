import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import './global.dart';
import './UserManager.dart';

class AuthManager {
  //회원 등록
  void registerUser(String userId, String userPwd) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");
    User user = User(userId, userPwd);

    ref.set({"userId": user.userId, "userPwd": user.userPwd});
    print("회원가입 성공!");
  }

  //로그인
  void loginUser(String userId, String userPwd) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");

    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      if (data != null && data is Map<Object?, Object?>) {
        if (data["userId"] == userId && data["userPwd"] == userPwd) {
          setLoggedInUserId(userId); //로그인 처리
          print("로그인 성공!");
        } else {
          print("로그인 실패!");
        }
      } else {
        print("DB오류");
      }
    });
  }
}
// 예은