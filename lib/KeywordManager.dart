import 'package:firebase_database/firebase_database.dart';
import './global.dart';
import './Keyword.dart';

class KeywordManager {
  String? userId;

  // 생성자
  KeywordManager(this.userId); // 생성자에 userId 넣어야 함(getLoggedInUserId() 전역 함수 사용)

  // 특정 유저의 키워드를 List 형태로 가져오기
  Future<List<Keyword>> getMyKeywords() async {
    List<Keyword> myKeywords = [];

    DatabaseReference ref =
    FirebaseDatabase.instance.ref("users/${this.userId}/keywords");

    final snapshot = await ref.get();

    if (snapshot.exists) {
      // snapshot 존재하면
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        // Map을 돌면서
        bool isActivated;
        if (value["isActivated"].toLowerCase() == "true") {
          isActivated = true;
        } else {
          isActivated = false;
        }
        Keyword keyword = Keyword(value["keyWord"], isActivated); // 키워드 객체 생성
        myKeywords.add(keyword); // List에 추가
      });

      return myKeywords;
    } else {
      // 존재하지 않으면 빈 배열 반환
      return [];
    }
  }

  // 키워드 추가 (string 기반으로 간단히 추가)
  Future<void> addKeyword(String keyword) async {
    DatabaseReference ref =
    FirebaseDatabase.instance.ref("users/${this.userId}/keywords").push();

    // Firebase에 키워드 추가
    ref.set({
      "keyWord": keyword,
      "isActivated": true, // 기본 활성화 상태
    });

    print("$keyword 키워드 추가 완료!");
  }

  // 기존 메소드들 유지...

  Future<void> removeKeyword(Keyword keyWord) async {
    DatabaseReference ref =
    FirebaseDatabase.instance.ref("users/${this.userId}/keywords");

    final snapshot = await ref.get();
    if (snapshot.exists) {
      // 키워드 순회
      for (var i = 0; i < snapshot.children.length; i++) {
        var child = snapshot.children.elementAt(i); // 여기서 children은 키워드의 키값

        if (child.child("keyWord").value == keyWord.keyWord) {
          // 해당 키워드 일치하면 삭제
          await child.ref.remove();
          print("${keyWord.keyWord} 키워드 삭제 완료");

          return;
        }
      }
      print("${keyWord.keyWord}를 찾지 못했음");
    } else {
      print("키워드 목록 비어있음");
    }
  }

  // 키워드 활성화
  Future<void> activateKeyword(Keyword keyWord) async {
    DatabaseReference ref =
    FirebaseDatabase.instance.ref("users/${this.userId}/keywords");

    final snapshot = await ref.get();

    if (snapshot.exists) {
      // 키워드 순회
      for (var i = 0; i < snapshot.children.length; i++) {
        var child = snapshot.children.elementAt(i);

        if (child.child("keyWord").value == keyWord.keyWord) {
          await child.ref.update({"isActivated": "true"});
          print("${keyWord.keyWord} 활성화 완료");
          return;
        }
        print("${keyWord.keyWord}를 찾지 못했음 활성화 불가");
      }
    } else {
      print("키워드 목록 비어있음");
    }
  }

  // 키워드 비활성화
  Future<void> deactivateKeyword(Keyword keyWord) async {
    DatabaseReference ref =
    FirebaseDatabase.instance.ref("users/${this.userId}/keywords");

    final snapshot = await ref.get();
    if (snapshot.exists) {
      for (var i = 0; i < snapshot.children.length; i++) {
        var child = snapshot.children.elementAt(i);

        if (child.child("keyWord").value == keyWord.keyWord) {
          await child.ref.update({"isActivated": "false"});
          print("${keyWord.keyWord} 비활성화 완료");
          return;
        }
        print("${keyWord.keyWord}를 찾지 못했음 비활성화 불가");
      }
    } else {
      print("키워드 목록 비어있음");
    }
  }
}
