import 'package:firebase_database/firebase_database.dart';
import '../News.dart';
import '../models/product.dart';

class NewsService {
  // 일반 뉴스 데이터를 저장한 Firebase "news" 노드 참조
  final DatabaseReference _newsRef = FirebaseDatabase.instance.ref("news");

  // 특정 사용자의 뉴스 스크랩 데이터를 참조하는 메소드
  DatabaseReference _getUserNewsRef(String userId) {
    return FirebaseDatabase.instance.ref("users/$userId/myNews");
  }

  /// Firebase "news" 노드에서 일반 뉴스를 가져옴
  Future<List<Product>> fetchNews() async {
    final snapshot = await _newsRef.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;

      // 디버깅: 데이터를 출력
      print("Firebase에서 가져온 데이터: $data");

      return data.values.map((item) {
        print("각 Product 데이터: $item");
        return Product(
          title: item['title'] ?? '제목 없음',
          publishedAt: item['published'] ?? '알 수 없음',
          urlToImage: item['urlToImage'] ?? '',
          price: item['price'] ?? '0',
          address: item['address'] ?? '알 수 없음',
          heartCount: item['heartCount'] ?? 0,
          commentsCount: item['commentsCount'] ?? 0,
        );
      }).toList();
    }
    print("Firebase 데이터 없음");
    return [];
  }


  /// 특정 사용자의 스크랩 뉴스("users/$userId/myNews")를 가져옴
  Future<List<News>> getMyNews(String userId) async {
    DatabaseReference ref = _getUserNewsRef(userId);
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

  /// 특정 사용자의 스크랩 뉴스("users/$userId/myNews")에 뉴스 추가
  Future<void> addMyNews(String userId, News news) async {
    DatabaseReference ref = _getUserNewsRef(userId).push();

    Map<String, String> mapMyNews = {
      "title": news.title,
      "link": news.link,
      "published": news.published,
    };

    await ref.set(mapMyNews);
  }
}
