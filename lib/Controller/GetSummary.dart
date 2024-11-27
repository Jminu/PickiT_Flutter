import 'package:http/http.dart' as http;

/*
* 이 함수는 요약본을 제공하는 함수임
* API를 호출하며 body에 link를 실어서 보낸다.
* 요청된 python 함수에서는 전달받은 link에서 원문을 추출하고
* 요약본을 response로 제공해준다.
* */
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
