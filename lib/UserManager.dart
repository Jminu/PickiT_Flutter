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

  void getUserKeywords() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("/users/${userId}/keywords");

    final snapshot = await ref.get(); //keyword스냅샷 가져옴

    if (snapshot.exists) {
      print(snapshot);
    } else {
      //존재안하면
      print("No data!");
    }
  }
}
