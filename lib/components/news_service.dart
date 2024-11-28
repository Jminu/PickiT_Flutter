import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import '../News.dart';
import '../models/product.dart';
import '../global.dart'; // getLoggedInUserId() 함수 사용

class NewsService {
  // Firebase에서 "news" 노드 참조
  final DatabaseReference _newsRef = FirebaseDatabase.instance.ref("news");

  // 특정 사용자의 뉴스 스크랩 데이터를 참조하는 메소드
  DatabaseReference _getUserNewsRef(String userId) {
    return FirebaseDatabase.instance.ref("users/$userId/myNews");
  }

  /// **서버에서 유저 키워드 기반 필터링된 뉴스 가져오기**
  Future<List<News>> getFilteredFeeds() async {
    String? userId = getLoggedInUserId(); // 현재 로그인된 유저 ID 가져오기
    if (userId == null) {
      throw Exception("유저 ID를 가져올 수 없습니다. 로그인하세요.");
    }

    final response = await http.post(
      Uri.parse("https://getfilterednewslist-z5lahfby6q-uc.a.run.app"),
      body: {
        'userId': userId,
      },
    );

    if (response.statusCode == 200) {
      List<News> filteredNews = [];
      print("서버로 userId 전달 성공. 필터링된 뉴스 데이터를 받았습니다.");
      List<dynamic> filteredFeeds = jsonDecode(response.body); // JSON을 리스트로 변환

      for (var feed in filteredFeeds) {
        News news = News(
          feed["title"],
          feed["link"],
          feed["published"],
        );
        filteredNews.add(news); // News 객체 리스트에 추가
      }

      return filteredNews;
    } else {
      print("서버에서 데이터를 가져오지 못했습니다: ${response.statusCode}");
      return []; // 빈 리스트 반환
    }
  }

  /// **Firebase에서 모든 뉴스를 가져오기 ("news" 노드 사용)**
  Future<List<Product>> fetchNews() async {
    final snapshot = await _newsRef.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      return data.values.map((item) {
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
    return [];
  }

  /// **Firebase에서 특정 사용자의 스크랩 뉴스 가져오기**
  Future<List<News>> getMyNews(String userId) async {
    DatabaseReference ref = _getUserNewsRef(userId);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      return data.keys.map((key) {
        return News(
          data[key]['title'],
          data[key]['link'],
          data[key]['published'],
        );
      }).toList();
    }
    return [];
  }

  /// 특정 사용자의 스크랩 뉴스("users/$userId/myNews")에 뉴스 추가
  /// **Firebase에서 특정 사용자의 스크랩 뉴스 추가**
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
