import json

from firebase_functions import db_fn, https_fn
from firebase_admin import initialize_app, db
import logging

from FeedParser import filterRSSfeed
from AiSummary import getArticleContent, summarize_with_chatgpt

# firebase admin SDK초기화
app = initialize_app()

# logging 설정
logging.basicConfig(level=logging.INFO)  # 로그 레벨 설정


@https_fn.on_request()
def getFilteredNewsList(request: https_fn.Request) -> https_fn.Response:
    try:
        filteredList = filterRSSfeed(request)  # RSS feed에서 키워드 관련된 거 가져옴(리스트로)
        print(filteredList)
        # 리스트를 dart에 json으로 반환
        return https_fn.Response(json.dumps(filteredList), status=200, mimetype="application/json")

    except ValueError as e:
        return https_fn.Response(str(e), status=400)


@https_fn.on_request()
def getSummary(request: https_fn.Request) -> https_fn.Response:
    newsLink = request.form.get("link")  # 뉴스기사의 link를 받아옴
    if not newsLink:  # 뉴스링크 가져오는데 실패
        return https_fn.Response("뉴스 링크가 제공되지 않음", status=400)

    article = getArticleContent(newsLink)  # 기사내용 가져오고
    if not article:  # 기사내용 가져오는데 실패하면
        return https_fn.Response("기사내용을 가져오지 못함", status=404)

    summary = summarize_with_chatgpt(article)  # 기사 내용 요약
    print(summary)
    return https_fn.Response(summary, status=200)
