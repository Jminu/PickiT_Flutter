import json

from firebase_functions import db_fn, https_fn
from firebase_admin import initialize_app, db
import logging

from FeedParser import filterRSSfeed

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
