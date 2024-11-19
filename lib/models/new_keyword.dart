class Keyword {
  final String name;
  final bool isRegistered;

  Keyword({required this.name, this.isRegistered = false});
}

class News {
  final String title;
  final String content;
  final String imageUrl;
  final String category;

  News({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.category,
  });
}

// 예시 데이터
List<Keyword> allKeywords = [
  Keyword(name: "Flutter"),
  Keyword(name: "Dart"),
  Keyword(name: "Android"),
  Keyword(name: "Programming"),
  Keyword(name: "Machine Learning"),
  Keyword(name: "UI/UX Design"),
  Keyword(name: "iOS Development"),
  Keyword(name: "JavaScript"),
];

List<News> newsData = [
  News(
    title: "Flutter 3.0 Released",
    content: "Flutter 3.0 has been released with amazing features...",
    imageUrl: "https://example.com/flutter3.jpg",
    category: "Technology",
  ),
  News(
    title: "Dart 2.16 Features",
    content: "Dart 2.16 introduces new features for web development...",
    imageUrl: "https://example.com/dart16.jpg",
    category: "Programming",
  ),
  // 추가 뉴스 항목
];
