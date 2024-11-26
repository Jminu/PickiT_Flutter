import 'package:http/http.dart' as http;

Future<String> getSummary(String newsLink) async {
  String? link = newsLink;

  final response = await http.post(
    Uri.parse("https://getsummary-z5lahfby6q-uc.a.run.app"),
    body: {
      'link': link,
    },
  );

  if (response.statusCode == 200) {
    String summary = response.body;
    print("요약 받기 성공");
    return summary;
  } else {
    print("요약 받기 실패");
    return " ";
  }
}
