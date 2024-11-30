// https://trends.google.co.kr/trending?geo=KR&hours=168 나중에 활용

class KeywordData {
  final String title;
  final String? url;

  KeywordData({required this.title, required this.url});
}

List<KeywordData> exampleKeywords = [
  KeywordData(title: "Flutter", url: "https://flutter.dev"),
  KeywordData(title: "Dart", url: "https://dart.dev"),
  KeywordData(title: "Firebase", url: "https://firebase.google.com"),
  KeywordData(title: "React", url: "https://reactjs.org"),
  KeywordData(title: "Node.js", url: "https://nodejs.org"),
  KeywordData(title: "Python", url: "https://python.org"),
  KeywordData(title: "Java", url: "https://java.com"),
  KeywordData(title: "Kotlin", url: "https://kotlinlang.org"),
  KeywordData(title: "동덕", url: "https://www.ytn.co.kr/_ln/0103_202411291130191455"),
];
