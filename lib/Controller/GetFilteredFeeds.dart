import 'dart:convert';

import 'package:pickit_flutter/global.dart';
import 'package:http/http.dart' as http;

Future<void> getFilteredFeeds() async {
  String? userId = getLoggedInUserId();
  final response = await http.post(
    Uri.parse("https://getfilterednewslist-z5lahfby6q-uc.a.run.app"),
    body: {
      'userId': userId,
    },
  );

  if (response.statusCode == 200) {
    print("서버로 userId 보내기 성공");
    List<dynamic> filteredFeeds = jsonDecode(response.body);

    for(var feed in filteredFeeds) {
      print("피드 제목: ${feed["title"]}");
      print("링크: ${feed["link"]}");
      print("발행 날짜: ${feed["published"]}");
      print("==============================");
    }
  } else {
    print("서버로 userId 보내기 실패: ${response.statusCode}");
  }
}
