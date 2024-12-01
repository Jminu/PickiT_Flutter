class Product {
  final String title;
  final String publishedAt;
  final String urlToImage;
  final String price;
  final String address;
  final int heartCount;
  final int commentsCount;
  final String? author; // 선택적 필드
  final String? source; // 선택적 필드

  Product({
    required this.title,
    required this.publishedAt,
    required this.urlToImage,
    required this.price,
    required this.address,
    required this.heartCount,
    required this.commentsCount,
    this.author, // 선택적
    this.source, // 선택적
  });
}
