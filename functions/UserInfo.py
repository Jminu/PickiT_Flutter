from firebase_functions import https_fn
from firebase_admin import db


def getUserId(request: https_fn.Request) -> str:
    userId = request.form.get("userId")
    if not userId:
        raise ValueError("userId가 가져올 수 없음")
    return userId


# user의 키워드리스트를 가져오는 함수(리스트로 반환)
def getUserKeywordList(request: https_fn.Request) -> list:
    userKeywordList = []

    userId = getUserId(request)  # userId가져옴
    userRef = db.reference(f"/users/{userId}/keywords/")  # db에서 userId위치를 참조

    snapshot = userRef.get()  # 스냅샷 데이터 가져옴 (snapshot은 딕셔너리 객체)
    if not snapshot:  # 스냅샷 없으면 빈 배열 리턴
        print("스냅샷이 없음")
        return []

    for key, value in snapshot.items():  # key: {키워드의hashID} value: {keyWord, isActivated}
        userKeywordList.append(value)  # 빈 배열에 키워드 추가
    return userKeywordList  # 유저의 키워드 리스트 리턴
