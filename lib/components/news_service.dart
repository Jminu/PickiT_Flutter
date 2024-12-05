import 'package:firebase_database/firebase_database.dart';
import '../models/News.dart';

class NewsService {
  // 특정 사용자의 뉴스 스크랩 데이터를 참조하는 메소드
  DatabaseReference _getUserNewsRef(String userId) {
    return FirebaseDatabase.instance.ref("users/$userId/myNews");
  }

  /// 특정 사용자의 스크랩 뉴스 삭제
  Future<void> removeMyNews(String userId, String newsTitle) async {
    DatabaseReference ref = _getUserNewsRef(userId);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      for (var child in snapshot.children) {
        if (child.child("title").value == newsTitle) {
          await child.ref.remove();
          print("스크랩 뉴스 삭제 완료: $newsTitle");
          return;
        }
      }
    }
    print("삭제할 스크랩 뉴스를 찾을 수 없습니다.");
  }

  /// 스크랩 뉴스 업데이트
  Future<void> updateMyNews(
      String userId, String oldTitle, News updatedNews) async {
    DatabaseReference ref = _getUserNewsRef(userId);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      for (var child in snapshot.children) {
        if (child.child("title").value == oldTitle) {
          await child.ref.update({
            "title": updatedNews.title,
            "link": updatedNews.link,
            "published": updatedNews.published,
          });
          print("스크랩 뉴스 업데이트 완료: ${updatedNews.title}");
          return;
        }
      }
    }
    print("업데이트할 스크랩 뉴스를 찾을 수 없습니다.");
  }
}
