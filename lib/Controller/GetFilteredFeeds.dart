import 'dart:convert';

import 'package:pickit_flutter/global.dart';
import 'package:http/http.dart' as http;
import '../News.dart';

/*
* 이 함수는 키워드와 관련된 뉴스정보를 전달받는다(title, link, published)
* API요청하면 body에 userId를 실어서 보낸다.
* 요청된 python에서는 전달받은 userId를 활용해 DB에서 userId에 저장된 키워드 리스트
* 불러오고, 그 키워드 리스트들과 관련된 뉴스만 필터링해서 response한다.
*  */
Future<List<News>> getFilteredFeeds() async {
  String? userId = Global.getLoggedInUserId();

  if (userId == null) {
    throw Exception("유저 ID를 가져올 수 없습니다. 로그인하세요.");
  }

  final response = await http.post(
    Uri.parse("https://getfilterednewslist-z5lahfby6q-uc.a.run.app"),
    body: {'userId': userId},
  );

  if (response.statusCode == 200) {
    List<News> filteredNews = [];
    print("서버로 userId 보내기 성공");
    List<dynamic> filteredFeeds = jsonDecode(response.body);

    for (var feed in filteredFeeds) {
      News news = News(
        title: feed["title"],
        link: feed["link"],
        published: feed["published"],
        imageUrl: feed["imageUrl"]
      );
      filteredNews.add(news);
    }

    return filteredNews;
  } else {
    print("서버로 userId 보내기 실패: ${response.statusCode}");
    return [];
  }
}