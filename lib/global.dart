import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import './News.dart';

class Global {
  static String? loggedInUserId;

  static void setLoggedInUserId(String userId) {
    loggedInUserId = userId;
  }

  static void clearLoggedUserIn() {
    loggedInUserId = null;
  }

  static String? getLoggedInUserId() {
    return loggedInUserId;
  }

//뉴스 스크랩 함수(유저의 DB에 저장)
  static Future<void> addMyNews(String userId, News news) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/$userId/myNews").push();

    Map<String, String> mapMyNews = {
      "title": news.title,
      "link": news.link,
      "published": news.published,
    };

    print("유저 ID: $userId");
    print("저장할 뉴스 데이터: $mapMyNews");

    await ref.set(mapMyNews);
    print("뉴스 스크랩 완료");
  }

//스크랩한 뉴스를 가져옴
  static Future<List<News>> getMyNews(String userId) async {
    List<News> myNews = []; // 스크랩한 뉴스들을 저장

    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/$userId/myNews");
    final snapshot = await ref.get(); // DB에서 스크랩 뉴스 snapshot으로 가져옴

    if (snapshot.exists) {
      // 스크랩한 뉴스가 있다면
      Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>; // Map 객체로 변환

      for (var key in data.keys) {
        // 가져온 Map을 순회
        Map<String, dynamic> newsData = Map<String, dynamic>.from(data[key]);
        News news = News(
          newsData["title"] ?? "제목 없음",
          newsData["link"] ?? "링크 없음",
          newsData["published"] ?? "발행일 없음",
          newsData["imageUrl"] ?? "", // imageUrl 디폴트 값 처리
        );
        myNews.add(news);
      }
    } else {
      print("스크랩된 뉴스 데이터가 없음");
    }
    print("스크랩한 뉴스를 가져오기 성공");
    return myNews;
  }

  //나의 스크랩 목록에서 특정뉴스를 삭제(userId: 사용자아이디 title: 삭제하려는 뉴스 제목)
  //사용시 await붙여야함
  static Future<void> removeMyNews(String? userId, String title) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/$userId/myNews");
    final snapshot = await ref.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>; //Map객체로 변환
      String keyToDelete;

      for (var key in data.keys) {
        Map<String, dynamic> myNewsData = Map<String, dynamic>.from(data[key]);
        if (myNewsData["title"] == title) {
          //제목 일치하면
          keyToDelete = key; //삭제할 키 저장
          await ref.child(keyToDelete).remove(); //일치하는 뉴스의 키 삭제(스크랩 항목중에서)
          print("스크랩한 뉴스 삭제완료");
        }
      }
    } else {
      print("removeMyNews: snapshot이 존재하지 않음");
    }
  }
}
