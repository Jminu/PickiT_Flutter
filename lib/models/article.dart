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

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'],
        date: json['published'] ?? '', // JSON의 'published' 필드 사용
        imageUrl: json['imageUrl'] ?? '', // 이미지 필드 (필요 시 추가)
        content: json['content'] ?? '', // 콘텐츠 필드
    );
  }
}
