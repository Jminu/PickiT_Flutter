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

  List<Keyword> getUserKeywords() {
    return this.userKeywords;
  }
}
