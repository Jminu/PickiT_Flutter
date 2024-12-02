class Article {
  final String title;
  final String date;
  final String imageUrl;
  final String content;
  final String url; // 새롭게 추가된 필드
  final String? author; // 선택적 필드
  final String? source; // 선택적 필드

  Article({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.content,
    required this.url, // 생성자에 추가
    this.author, // 선택적
    this.source, // 선택적
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      // JSON의 'title' 필드
      date: json['published'] ?? '',
      // JSON의 'published' 필드
      imageUrl: json['imageUrl'] ?? '',
      // JSON의 'imageUrl' 필드
      content: json['content'] ?? '',
      // JSON의 'content' 필드
      url: json['url'] ?? '', // 추가된 URL 필드
    );
  }
}