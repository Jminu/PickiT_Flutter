import 'package:firebase_database/firebase_database.dart';
import '../News.dart';

class NewsService {
  // 스크랩된 뉴스 가져오기
  Future<List<News>> getMyNews(String userId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId/myNews");
    final snapshot = await ref.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      return data.keys
          .map((key) => News(
        data[key]['title'],
        data[key]['link'],
        data[key]['published'],
      ))
          .toList();
    }
    return [];
  }

  // 뉴스 추가 로직도 이곳에 포함 가능
  Future<void> addMyNews(String userId, News news) async {
    DatabaseReference ref =
    FirebaseDatabase.instance.ref("users/$userId/myNews").push();

    Map<String, String> mapMyNews = {
      "title": news.title,
      "link": news.link,
      "published": news.published,
    };

    await ref.set(mapMyNews);
  }
}
