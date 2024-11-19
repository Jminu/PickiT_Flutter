import 'package:firebase_database/firebase_database.dart';

import './Keyword.dart';

class User {
  String userId;
  String userPwd;
  List<Keyword> userKeywords = [];

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

  void setUserPwd() {
    this.userPwd = userPwd;
  }

  Future<List<Map<dynamic, dynamic>>> getUserKeywords() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("/users/${userId}/keywords");

    final snapshot = await ref.get(); //keyword스냅샷 가져옴
    List<Map<dynamic, dynamic>> userKeywordList = [];

    if (snapshot.exists) {
      for (var i = 0; i < snapshot.children.length; i++) {
        var child = snapshot.children.elementAt(i);
        Map<dynamic, dynamic> keyWordMap = child.value as Map<dynamic, dynamic>;
        userKeywordList.add(keyWordMap);
      }
      //print(userKeywordList);
      return userKeywordList;
    } else {
      //존재안하면
      print("No data!");
      return [];
    }
  }
}
