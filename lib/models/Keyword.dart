class Keyword {
  String keyWord;
  bool isActivated;

  Keyword(this.keyWord, {this.isActivated = false});

  String getKeyword() {
    return this.keyWord;
  }

  bool getIsActivated() {
    return this.isActivated;
  }

  void setKeyword(String keyWord) {
    this.keyWord = keyWord;
  }

  void setActivate(bool activate) {
    this.isActivated = activate;
  }
}

// 추천 키워드 리스트
List<Keyword> recommendKeywords = [
  Keyword("Flutter"),
  Keyword("Dart"),
  Keyword("Firebase"),
  Keyword("React"),
  Keyword("Node.js"),
  Keyword("Python"),
  Keyword("Java"),
  Keyword("Kotlin"),
];
