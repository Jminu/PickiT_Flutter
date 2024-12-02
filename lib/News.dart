class News {
  String title;
  String link;
  String published;
  String? imageUrl; // 선택적 필드

  News(this.title, this.link, this.published, [this.imageUrl]);
}
