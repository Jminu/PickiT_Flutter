import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/News.dart';
import '../../global.dart';
import '../../models/article.dart';
import '../Article/article_screen.dart';
import 'package:firebase_database/firebase_database.dart'; // Firebase Realtime Database 사용

class MyScrapScreen extends StatefulWidget {
  final String? userId;

  const MyScrapScreen({Key? key, this.userId}) : super(key: key);

  @override
  _MyScrapScreenState createState() => _MyScrapScreenState();
}

class _MyScrapScreenState extends State<MyScrapScreen> {
  late Future<List<News>> _myNewsFuture;

  @override
  void initState() {
    super.initState();
    String? userId = widget.userId ?? Global.getLoggedInUserId();
    if (userId != null) {
      _myNewsFuture = Global.getMyNews(userId); // 유저 ID로 스크랩된 뉴스 호출
    } else {
      _myNewsFuture = Future.value([]); // 유저 ID가 없으면 빈 리스트 반환
    }
  }

  // 새로 고침 시 스크랩 뉴스 갱신
  Future<void> _refreshScrapNews() async {
    setState(() {
      String? userId = widget.userId ?? Global.getLoggedInUserId();
      if (userId != null) {
        _myNewsFuture = Global.getMyNews(userId);
      }
    });
  }

  // Firebase에서 뉴스 삭제하기
  Future<void> _deleteNewsFromFirebase(String userId, String newsTitle) async {
    try {
      await Global.removeMyNews(userId, newsTitle); // Global.removeMyNews를 통해 Firebase에서 삭제
      print("뉴스 삭제 성공");
      // 삭제 후 화면 갱신
      _refreshScrapNews();
    } catch (e) {
      print("뉴스 삭제 실패: $e");
    }
  }

  // 삭제 확인 팝업을 띄우는 함수
  void _showDeleteConfirmationDialog(String userId, String newsTitle) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("삭제하시겠습니까?"),
          content: Text("이 뉴스는 영구적으로 삭제됩니다."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 취소
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                _deleteNewsFromFirebase(userId, newsTitle); // 삭제
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text("삭제"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("스크랩한 뉴스"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshScrapNews,  // 새로 고침을 위한 함수 호출
        child: FutureBuilder<List<News>>(
          future: _myNewsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "오류 발생: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("스크랩한 뉴스가 없습니다."));
            } else {
              final myNewsList = snapshot.data!;
              return ListView.builder(
                itemCount: myNewsList.length,
                itemBuilder: (context, index) {
                  final news = myNewsList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleScreen(
                            article: Article(
                              title: news.title,
                              date: news.published,
                              imageUrl: "", // 이미지는 제거
                              content: "뉴스 본문을 여기에 추가하세요.",
                              url: news.link,
                            ),
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      String? userId = widget.userId ?? Global.getLoggedInUserId();
                      if (userId != null) {
                        _showDeleteConfirmationDialog(userId, news.title);
                      }
                    },
                    child: Card(
                      color: Colors.deepPurpleAccent[50], // 배경 색상 설정 (조정 가능)
                      elevation: 4, // 카드 그림자 효과
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // 둥근 모서리
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 이미지 관련 부분 제거
                            const SizedBox(height: 12),
                            Text(
                              news.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              news.published,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
