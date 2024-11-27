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
Future<List<dynamic>> getFilteredFeeds() async {
  String? userId = getLoggedInUserId();
  final response = await http.post(
    Uri.parse("https://getfilterednewslist-z5lahfby6q-uc.a.run.app"),
    body: {
      'userId': userId,
    },
  );

  if (response.statusCode == 200) {
    List<News> filteredNews = []; //필터링된 뉴스 정보(제목, 링크, 발행날짜)
    print("서버로 userId 보내기 성공");
    List<dynamic> filteredFeeds =
        jsonDecode(response.body); //응답받은 Json을 객체로 list에 저장

    for (var feed in filteredFeeds) {
      News news = News(
          feed["title"], feed["link"], feed["published"]); //뉴스 객체 생성해서 정보 넣음
      filteredNews.add(news); //생성한 뉴스 객체를, 뉴스 객체 리스트에 넣음
    }

    return filteredNews; //기사 리스트 반환
  } else {
    print("서버로 userId 보내기 실패: ${response.statusCode}");
    return []; //빈 값 반환
  }
}
