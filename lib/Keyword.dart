class Keyword {
  String keyWord;
  bool isActivated = true;

  Keyword(this.keyWord, this.isActivated);

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
