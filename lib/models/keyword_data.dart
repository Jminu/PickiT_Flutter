// https://trends.google.co.kr/trending?geo=KR&hours=168 나중에 활용

class KeywordData {
  final String keyword;
  final String url;
  bool registered;

  KeywordData({
    required this.keyword,
    required this.url,
    required this.registered,
  });
}

// 키워드 리스트 초기화
final List<KeywordData> keywordList = [
  KeywordData(
    keyword: "AI",
    url: "https://korea.gov/ai-service",
    registered: false,
  ),
  KeywordData(
    url: "https://seoulmetro.go.kr/smart-system",
    keyword: "스마트 교통",
    registered: false,
  ),
  KeywordData(
    url: "https://environews.kr/hanriver-cleanup",
    keyword: "환경",
    registered: false,
  ),
  KeywordData(
    url: "https://kpopnews.com/billboard-record",
    keyword: "K-POP",
    registered: false,
  ),
  KeywordData(
    url: "https://startupkorea.com/ai-healthcare",
    keyword: "스타트업",
    registered: false,
  ),
  KeywordData(
    url: "https://jeju.go.kr/carbon-free",
    keyword: "탄소 중립",
    registered: false,
  ),
  KeywordData(
    url: "https://koreanfilm.com/cannes-award",
    keyword: "영화",
    registered: false,
  ),
  KeywordData(
    url: "https://5gnews.kr/korea-5g",
    keyword: "5G",
    registered: false,
  ),
];

// 키워드 등록/해제 관리 로직
class KeywordManager {
  final List<KeywordData> registeredKeywords = [];

  // 키워드 등록/해제 처리
  void toggleKeyword(KeywordData keywordData) {
    if (registeredKeywords.contains(keywordData)) {
      registeredKeywords.remove(keywordData);
      keywordData.registered = false;
    } else {
      registeredKeywords.add(keywordData);
      keywordData.registered = true;
    }
  }

  // 등록된 키워드 삭제
  void removeKeyword(KeywordData keywordData) {
    registeredKeywords.remove(keywordData);
    keywordData.registered = false;
  }
}
