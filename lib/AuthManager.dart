import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import './global.dart';
import './UserManager.dart';

class AuthManager {
  //회원 등록
  bool registerUser(String userId, String userPwd) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");
    User user = User(userId, userPwd);

    ref.set({"userId": user.userId, "userPwd": user.userPwd});
    print("회원가입 성공!");
    return true;
  }

  //로그인
  Future<bool> loginUser(String userId, String userPwd) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");
    final snapshot = await ref.get();

    if (snapshot.exists) {
      //DB에 아이디가 있다면
      final data = snapshot.value; //스냅샷의 데이터를 저장
      print("Snapshot value: ${snapshot.value}");

      if (data != null && data is Map<dynamic, dynamic>) {
        //아이디 비밀번호, DB에 있는 것과 맞는지 확인
        if (data["userId"] == userId && data["userPwd"] == userPwd) {
          setLoggedInUserId(userId);
          print("로그인 성공");
          return true;
        } else {
          print("로그인 실패");
          return false;
        }
      } else {
        print("구조 이상");
        return false;
      }
    } else {
      //아이디가 없을때
      print("사용자를 찾을 수 없음");
      return false;
    }
  }
}
// 예은
