import 'article.dart';

class News {
  String title;
  String link;
  String published;
  String? imageUrl; // 선택적 필드

  News({
    required this.title,
    required this.link,
    required this.published,
    this.imageUrl, // 선택적 필드
  });

  // News 객체를 Article 객체로 변환하는 메서드
  Article toArticle() {
    return Article(
      title: this.title,
      url: this.link,  // News의 link -> Article의 url
      date: this.published, // News의 published -> Article의 date
      imageUrl: this.imageUrl ?? "",  // imageUrl 디폴트 값 처리
      content: "",  // 기본값을 빈 문자열로 지정
    );
  }
}
