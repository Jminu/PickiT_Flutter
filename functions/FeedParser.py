import feedparser
from firebase_functions import https_fn
from UserInfo import getUserKeywordList

RSS_FEED = [
    "https://www.chosun.com/arc/outboundfeeds/rss/?outputType=xml",  # 조선
    "https://rss.donga.com/total.xml",  # 동아
    "https://www.mk.co.kr/rss/40300001/",  # 매일경제
    "https://www.hankyung.com/feed/all-news",  # 한국경제
    "https://www.yonhapnewstv.co.kr/browse/feed/",  # 연합뉴스
    "https://www.khan.co.kr/rss/rssdata/total_news.xml",  # 경향신문
    "http://www.joongang.tv/rss/allArticle.xml",  # 중앙일보
    "http://rss.kmib.co.kr/data/kmibRssAll.xml",  # 국민일보
    "https://www.mediatoday.co.kr/rss/allArticle.xml",  # 미디어오늘
    "https://www.hani.co.kr/rss/"  # 한겨례 신문
    "https://www.pressian.com/api/v3/site/rss/news",  # 프레시안
    "https://www.ablenews.co.kr/rss/allArticle.xml",  # 에이블뉴스
    "http://www.sisajournal.com/rss/allArticle.xml" # 시사저널
    "http://www.segye.com/Articles/RSSList/segye_recent.xml" # 세계일보
    # "https://akngs.github.io/knews-rss/all.xml" # RSS feed모음(from gitHub)
]


# url에서 RSS feed가져옴
def fetchRSSfeed() -> list:
    allArticles = []
    for feedUrl in RSS_FEED:
        try:
            feed = feedparser.parse(feedUrl)  # 피드 데이터를 파싱
            print(f"{feedUrl}에서 기사를 가져옵니다.")
            for entry in feed.entries:  # 각 항목에 대한 처리
                imageUrl = None  # 이미지 주소
                # media_content에서 이미지 URL 추출
                if "media_content" in entry and len(entry.media_content) > 0:
                    imageUrl = entry.media_content[0].get("url", None)

                # enclosures에서 이미지 URL 추출
                if not imageUrl and "enclosures" in entry and len(entry.enclosures) > 0:
                    imageUrl = entry.enclosures[0].get("href", None)

                if not imageUrl and "media_thumnail" in entry:
                    imageUrl = entry.media_thumbnail[0].get("url", None)

                article = {
                    "title": entry.title,  # 파싱한 기사 타이틀
                    "link": entry.link,  # 파싱한 기사 링크
                    "published": entry.published,  # 파싱한 기사 발행날짜
                    "imageUrl": imageUrl  # 이미지(썸내일)가져올 Url
                }
                allArticles.append(article)
        except Exception as e:
            print(f"Error fetching RSS feed from {feedUrl}: {e}")
            continue
    print(f"총 {len(allArticles)}개의 기사를 가져옴")
    return allArticles


# 긁어온 RSS feed의 title에 사용자가 설정한 키워드가 있다면 필터링해서 list에 넣음
def filterRSSfeed(request: https_fn.Request) -> list:
    filteredList = []
    userKeywordList = getUserKeywordList(request)  # 유저의 키워드 리스트 가져옴
    allArticles = fetchRSSfeed()  # RSS피드 전부 가져옴
    for article in allArticles:  # 파싱한 피드의 title에 유저의 키워드가 포함되어있는지 확인
        title = article["title"]
        for keyword in userKeywordList:
            if keyword["keyWord"].lower() in title.lower():
                filteredList.append(article)  # 있으면 리스트에 추가
                break
    return filteredList
