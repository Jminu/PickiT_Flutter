from firebase_functions import db_fn, https_fn
from firebase_admin import initialize_app, db
import logging

# firebase admin SDK초기화
app = initialize_app()

# logging 설정
logging.basicConfig(level=logging.INFO)  # 로그 레벨 설정

RSS_FEEDS = [
    "https://news.google.com/rss",  # Google News
    "https://rss.cnn.com/rss/edition.rss",  # CNN
]


def getUserId(request: https_fn.Request) -> str:
    userId = request.form.get("userId")
    if not userId:
        raise ValueError("userId가 제공되지 않음")
    print(f"userId를 성공적으로 받음(getUserId) :{userId}")
    return userId


# user의 키워드 목록 가져옴
@https_fn.on_request()
def fetchUserKeywordList(
        requset: https_fn.Request) -> https_fn.Response:
    try:
        userId = getUserId(requset)
        print(f"fetchUserKeywordList 호출: userId={userId}")

        userRef = db.reference(f"/users/minu/keywords/")
        snapshot = userRef.get()  # 스냅샷 데이터 가져오기
        print(f"Snapshot: {snapshot}")

        if not snapshot:
            return https_fn.Response("키워드 목록 없음", status=404)

        # https_fn.Response가 자동으로 json으로 변환
        return https_fn.Response(snapshot, status=200, mimetype="application/json")
    except ValueError as e:
        return https_fn.Response(str(e), status=400)
