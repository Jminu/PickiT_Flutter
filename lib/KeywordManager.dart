import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import './global.dart';
import './Keyword.dart';
import './UserManager.dart';

class KeywordManager {
  final User user;

  //생성자
  KeywordManager(this.user);

  //키워드 추가(json형식으로 저장)
  Future<void> addKeyword(Keyword keyWord) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("users/${this.user.userId}/keywords")
        .push();

    Map<String, String> mapKeyword = {
      //Map형태로 변환해야함(객체를)
      "keyWord": keyWord.keyWord,
      "isActivated": keyWord.isActivated.toString()
    };

    await ref.set(mapKeyword);

    print("키워드 추가 완료!");
  }

  Future<void> removeKeyword(Keyword keyWord) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${this.user.userId}/keywords");

    final snapshot = await ref.get();
    if (snapshot.exists) {
      //키워드 순회
      for (var i = 0; i < snapshot.children.length; i++) {
        var child = snapshot.children.elementAt(i); //여기서 children은 키워드의 키값

        if (child.child("keyWord").value == keyWord.keyWord) {
          //해당 키워드 일치하면 삭제
          await child.ref.remove();
          print(keyWord.keyWord + "키워드 삭제 완료");

          return;
        }
      }
      print(keyWord.keyWord + "를 찾지 못했음");
    } else {
      print("키워드 목록 비어있음");
    }
  }

  //키워드 활성화
  Future<void> activateKeyword(Keyword keyWord) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${this.user.userId}/keywords");

    final snapshot = await ref.get();

    if (snapshot.exists) {
      //키워드 순회
      for (var i = 0; i < snapshot.children.length; i++) {
        var child = snapshot.children.elementAt(i);

        if (child.child("keyWord").value == keyWord.keyWord) {
          await child.ref.update({"isActivated": "true"});
          print(keyWord.keyWord + "를 활성화 완료");
          return;
        }
        print(keyWord.keyWord + "를 찾지 못했음 활성화 불가");
      }
    } else {
      print("키워드 목록 비어있음");
    }
  }

  //키워드 비활성화
  Future<void> deactivateKeyword(Keyword keyWord) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${this.user.userId}/keywords");

    final snapshot = await ref.get();
    if (snapshot.exists) {
      for (var i = 0; i < snapshot.children.length; i++) {
        var child = snapshot.children.elementAt(i);

        if (child.child("keyWord").value == keyWord.keyWord) {
          await child.ref.update({"isActivated": "false"});
          print(keyWord.keyWord + "를 비활성화 완료");
          return;
        }
        print(keyWord.keyWord + "를 찾지 못했음 비활성화 불가");
      }
    } else {
      print("키워드 목록 비어있음");
    }
  }

  Future<void> fetchUserKeywordList() async {
    String? userId = getLoggedInUserId(); //userId가져오고(현재 로그인 되어있는)
    final response = await http.post(
      Uri.parse("https://fetchuserkeywordlist-z5lahfby6q-uc.a.run.app"),
      body: {
        'userId': userId,
      },
    );

    if (response.statusCode == 200) {
      print("서버로 유저아이디 성공적으로 보냄");
    } else {
      print("서버로 유저아이디 보내기 실패 error code : ${response.statusCode}");
    }
  }
}
