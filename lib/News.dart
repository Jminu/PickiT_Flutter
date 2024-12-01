class News {
  String title;
  String link;
  String published;
  String? imageUrl; // Add imageUrl as an optional field

  News(this.title, this.link, this.published, [this.imageUrl]);
}
