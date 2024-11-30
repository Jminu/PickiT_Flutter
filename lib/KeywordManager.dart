import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import './global.dart';
import './Keyword.dart';
import './UserManager.dart';

class KeywordManager {
  String? userId;

  //생성자
  KeywordManager(this.userId); //생성자에 userId넣어야함 getLoggedInUserId()전역함수 사용

  //특정유저의 키워드를 List형태로
  Future<List<Keyword>> getMyKeywords() async {
    List<Keyword> myKeywords = [];

    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${this.userId}/keywords"); //

    final snapshot = await ref.get();

    if (snapshot.exists) {
      //snapshot 존재하면
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        //Map을 돌면서
        bool isActivated;
        if (value["isActivated"].toLowerCase() == "true") {
          isActivated = true;
        } else {
          isActivated = false;
        }
        Keyword keyword = Keyword(value["keyWord"], isActivated); //키워드 객체를 생성
        myKeywords.add(keyword); //List에 넣음
      });

      return myKeywords;
    } else {
      //존재 안하면 빈배열 반환
      return [];
    }
  }

  //키워드 추가(json형식으로 저장)
  Future<void> addKeyword(Keyword keyWord) async {
    // 키워드가 중복으로 등록되는 경우가 있어서 추가
    bool exists = await _checkIfKeywordExists(keyWord.keyWord);

    if (exists) {
      print("이미 등록된 키워드입니다.");
      return; // 키워드가 이미 존재하면 추가하지 않음
    }

    // 새로운 키워드를 추가
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${this.userId}/keywords").push();

    Map<String, String> mapKeyword = {
      //Map형태로 변환해야함(객체를)
      "keyWord": keyWord.keyWord,
      "isActivated": keyWord.isActivated.toString()
    };

    await ref.set(mapKeyword);

    print("키워드 추가 완료!");
  }

  //키워드 존재 여부 확인
  Future<bool> _checkIfKeywordExists(String keywordText) async {
    List<Keyword> myKeywords = await getMyKeywords();

    // 현재 키워드 목록에서 중복된 키워드가 있는지 확인
    for (var keyword in myKeywords) {
      if (keyword.keyWord == keywordText) {
        return true; // 중복된 키워드가 있으면 true 반환
      }
    }
    return false; // 중복된 키워드가 없으면 false 반환
  }

  Future<void> removeKeyword(Keyword keyWord) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${this.userId}/keywords");

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
        FirebaseDatabase.instance.ref("users/${this.userId}/keywords");

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
        FirebaseDatabase.instance.ref("users/${this.userId}/keywords");

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
}
