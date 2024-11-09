import 'package:firebase_database/firebase_database.dart';

import './global.dart';
import './Keyword.dart';
import './UserManager.dart';

class KeywordManager {
  User user;

  KeywordManager(this.user);

  //키워드 추가
  void addKeyword(Keyword keyWord) {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${this.user.userId}/keywords/${keyWord.keyWord}"); //디비참조

    user.userKeywords.add(keyWord);

    Map<String, String> mapKeyword = { //Map형태로 변환해야함(객체를)
      "keyWord": keyWord.keyWord,
      "isActivated": keyWord.isActivated.toString()
    };

    ref.set(mapKeyword);

    print("키워드 추가 완료!");
  }

  //키워드 삭제
  void removeKeyword(Keyword keyWord) {
    user.userKeywords.remove(keyWord);
  }

  //키워드 활성화
  void activateKeyword(Keyword keyWord) {
    var index = user.userKeywords.indexOf(keyWord);
    user.userKeywords[index].isActivated = true;
  }

  //키워드 비활성화
  void deactivateKeyword(Keyword keyWord) {
    var index = user.userKeywords.indexOf(keyWord);
    user.userKeywords[index].isActivated = false;
  }
}
