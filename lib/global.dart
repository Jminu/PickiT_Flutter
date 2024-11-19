import 'package:http/http.dart' as http;

String? loggedInUserId;

void setLoggedInUserId(String userId) {
  loggedInUserId = userId;
}

void clearLoggedUserIn() {
  loggedInUserId = null;
}

String? getLoggedInUserId() {
  return loggedInUserId;
}

Future<void> fetchUserId() async {
  String? userId = getLoggedInUserId();
  if (userId == null) {
    print("현재 로그인하고있지 않음");
    return;
  }

  final response = await http.post(
    Uri.parse("https://fetchuserid-z5lahfby6q-uc.a.run.app"),
    body: {
      'userId': userId,
    },
  );

  if (response.statusCode == 200) {
    print("서버로 유저아이디 성공적으로 보냄");
  } else {
    print("서버로 유저아이디 안보내짐");
  }
}
