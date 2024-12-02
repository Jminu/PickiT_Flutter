class Keyword {
  String keyWord;
  bool isActivated;

  Keyword(this.keyWord, [this.isActivated = true]);

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
