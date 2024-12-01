import 'package:firebase_database/firebase_database.dart';

Future<void> showDB() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  final snapshot = await ref.get();

  if (snapshot.exists) {
    // 계층적으로 데이터를 출력
    print("데이터베이스 상태:");
    _printNestedData(snapshot.value, 0);
  } else {
    print("데이터베이스 없음");
  }
}

// 재귀적으로 데이터를 계층적으로 출력
void _printNestedData(dynamic data, int indent) {
  final String indentString = '  ' * indent; // 들여쓰기 생성

  if (data is Map) {
    data.forEach((key, value) {
      print('$indentString$key:'); // 현재 키 출력
      _printNestedData(value, indent + 1); // 값이 Map이면 더 깊이 탐색
    });
  } else if (data is List) {
    for (int i = 0; i < data.length; i++) {
      print('$indentString[$i]:');
      _printNestedData(data[i], indent + 1); // 리스트 항목 출력
    }
  } else {
    print('$indentString$data'); // 기본 데이터 출력
  }
}
