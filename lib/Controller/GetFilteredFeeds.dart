import 'dart:convert';

import 'package:pickit_flutter/global.dart';
import 'package:http/http.dart' as http;
import '../News.dart';

/*
관련된 기사를 가져오고, 그 기사 리스트를 반환하는 함수
 */
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
