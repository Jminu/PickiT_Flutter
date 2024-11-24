class Article {
  final String title;
  final String date;
  final String imageUrl;
  final String content;
  final String? author; // 선택적 필드
  final String? source; // 선택적 필드

  Article({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.content,
    this.author, // 선택적
    this.source, // 선택적
  });
}
