import feedparser
import certifi
import ssl
import urllib.request
from firebase_functions import https_fn
from UserInfo import getUserKeywordList

# SSL 인증서를 certifi에서 제공하는 것으로 사용하도록 SSLContext 설정
ssl_context = ssl.create_default_context(cafile=certifi.where())

# 언론사 리스트
RSS_FEED = [
    "https://www.chosun.com/arc/outboundfeeds/rss/?outputType=xml",
    "http://www.yonhapnewstv.co.kr/browse/feed/"
]


# url에서 RSS feed가져옴
def fetchRSSfeed() -> list:
    allArticles = []
    for feedUrl in RSS_FEED:
        with urllib.request.urlopen(feedUrl,
                                    context=ssl_context) as response:
            data = response.read()
        feed = feedparser.parse(data)  # 피드 데이터를 파싱
        for entry in feed.entries:  # 각 항목에 대한 처리
            article = {
                "title": entry.title,  # 파싱한 기사 타이틀
                "link": entry.link,  # 파싱한 기사 링크
                "published": entry.published  # 파싱한 기사 발행날짜
            }
            allArticles.append(article)
    print(f"총 {len(allArticles)}개의 기사를 가져옴")
    return allArticles


# 긁어온 RSS feed의 title에 사용자가 설정한 키워드가 있다면 필터링해서 list에 넣음
def filterRSSfeed(request: https_fn.Request) -> list:
    filteredList = []
    userKeywordList = getUserKeywordList(request)  # 유저의 키워드 리스트 가져옴
    allArticles = fetchRSSfeed() # RSS피드 전부 가져옴
    for article in allArticles:  # 파싱한 피드의 title에 유저의 키워드가 포함되어있는지 확인
        title = article["title"]
        for keyword in userKeywordList:
            if keyword["keyWord"].lower() in title.lower():
                filteredList.append(article)  # 있으면 리스트에 추가
                break;
    return filteredList
