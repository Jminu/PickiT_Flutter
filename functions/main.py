from firebase_functions import db_fn, https_fn
from firebase_admin import initialize_app, db
import logging

# import feedparser
# print(feedparser.__version__)

# firebase admin SDK초기화
app = initialize_app()

# logging 설정
logging.basicConfig(level=logging.INFO)  # 로그 레벨 설정


RSS_FEEDS = [
    "https://news.google.com/rss",  # Google News
    "https://rss.cnn.com/rss/edition.rss",  # CNN
]


# userId가져옴
@https_fn.on_request()
def fetchUserId(request: https_fn.Request) -> https_fn.Response:
    userId = request.form.get("userId")
    if not userId:
        return https_fn.Response("userId가 제공되지 않았음", 400)

    print(f"{userId}를 성공적으로 받음 print문")  # logging 대신 print 사용
    return https_fn.Response(userId, status=200)


# user의 키워드 목록 가져옴
@https_fn.on_request()
def fetchUserKeywordList(requset: https_fn.Request) -> https_fn.Response:
    userId = requset.form.get("userId")
    if not userId:
        return https_fn.Response("userId가 제공되지 않았음", 400)

    userRef = db.reference(f"/users/${userId}/keywords")  # 유저의 키워드목록 참조
    snapshot = userRef.get()  # 스냅샷
    if not snapshot:
        return https_fn.Response("키워드 목록 없음", status=404)
