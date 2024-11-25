import 'package:firebase_database/firebase_database.dart';

import './Keyword.dart';
import './News.dart';

class User {
  String userId;
  String userPwd;
  List<Keyword> userKeywords = [];
  List<News> myNews = []; //스크랩 해놓은 뉴스

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

  //뉴스 스크랩 함수(유저의 DB에 저장)
  Future<void> addMyNews(News news) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${this.userId}/myNews").push();

    //뉴스를 Map형식으로 변환
    Map<String, String> mapMyNews = {
      "title": news.title,
      "link": news.link,
      "published": news.published
    };

    //뉴스를 DB에 넣음
    await ref.set(mapMyNews);
    print("뉴스 스크랩 완료");
  }

  //스크랩한 뉴스를 가져옴
  Future<List<News>> getMyNews() async {
    List<News> myNews = []; //스크랩한 뉴스들을 저장

    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${this.userId}/myNews");
    final snapshot = await ref.get(); //DB에서 스크랩 뉴스 snapshot으로 가져옴

    if (snapshot.exists) {
      //스크랩한 뉴스가 있다면
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic,
          dynamic>; //Map객체로 바꾸고 (Key: 뉴스키 Value: title, link, published)

      for (var key in data.keys) {
        //가져온 Map을 순회
        Map<String, dynamic> newsData = Map<String, dynamic>.from(data[key]);
        News news =
            News(newsData["title"], newsData["link"], newsData["published"]);
        myNews.add(news);
      }
    }
    print("스크랩한 뉴스를 가져오기 성공");
    return myNews;
  }
}
