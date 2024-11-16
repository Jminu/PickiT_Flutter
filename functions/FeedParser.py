import feedparser
import certifi
import ssl
import urllib.request

# SSL 인증서를 certifi에서 제공하는 것으로 사용하도록 SSLContext 설정
ssl_context = ssl.create_default_context(cafile=certifi.where())

feed_url = "https://www.chosun.com/arc/outboundfeeds/rss/?outputType=xml"

# 언론사 리스트
RSS_FEED = [
    "https://www.chosun.com/arc/outboundfeeds/rss/?outputType=xml",
    "http://www.yonhapnewstv.co.kr/browse/feed/"
]

allArticles = []


def fetchRSSfeed() -> list:
    for feedUrl in RSS_FEED:
        with urllib.request.urlopen(feedUrl,
                                    context=ssl_context) as response:
            data = response.read()
        feed = feedparser.parse(data) # 피드 데이터를 파싱
        for entry in feed.entries: # 각 항목에 대한 처리
            article = {
                "title": entry.title,
                "link": entry.link,
                "published": entry.published
            }
            allArticles.append(article)
    print(f"총 {len(allArticles)}개의 기사를 가져옴")
    return allArticles


print(fetchRSSfeed())
