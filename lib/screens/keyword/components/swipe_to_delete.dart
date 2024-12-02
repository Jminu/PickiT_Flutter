import 'package:flutter/material.dart';
import 'package:pickit_flutter/global.dart'; // Global 클래스
import '../../../News.dart';
import '../../Article/article_screen.dart';

class SwipeToDelete extends StatelessWidget {
  final Widget child; // 삭제될 UI
  final VoidCallback onDelete; // 삭제 동작

  const SwipeToDelete({required this.child, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(child.hashCode.toString()), // 고유한 key를 사용
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        print('스와이프 종료');
        onDelete(); // 삭제 콜백 호출
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: child,
    );
  }
}

class MyScrapScreen extends StatefulWidget {
  final String? userId; // userId를 필드로 추가

  const MyScrapScreen({Key? key, this.userId}) : super(key: key);

  @override
  _MyScrapScreenState createState() => _MyScrapScreenState();
}

class _MyScrapScreenState extends State<MyScrapScreen> {
  late Future<List<News>> _myNewsFuture;

  @override
  void initState() {
    super.initState();
    String? userId = widget.userId ?? Global.getLoggedInUserId(); // 전달된 userId 또는 글로벌 ID
    if (userId != null) {
      _myNewsFuture = Global.getMyNews(userId); // 유저 ID로 스크랩된 뉴스 호출
    } else {
      _myNewsFuture = Future.value([]); // 유저 ID가 없으면 빈 리스트 반환
    }
  }

  // 뉴스 삭제 함수
  Future<void> _deleteNews(News news) async {
    String? userId = Global.getLoggedInUserId();
    if (userId != null) {
      await Global.deleteMyNews(userId, news);  // 데이터베이스에서 뉴스 삭제
      setState(() {
        _myNewsFuture = Global.getMyNews(userId); // 삭제 후, 뉴스 리스트를 다시 불러오기
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("뉴스가 삭제되었습니다.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("스크랩한 뉴스"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<News>>(
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
            return const Center(
              child: Text(
                "스크랩된 뉴스가 없습니다.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          } else {
            final myNews = snapshot.data!;
            return ListView.builder(
              itemCount: myNews.length,
              itemBuilder: (context, index) {
                final news = myNews[index];
                return SwipeToDelete(
                  child: ListTile(
                    title: Text(news.title),
                    subtitle: Text(news.published),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      final article = news.toArticle();
                      // 뉴스 클릭 시 ArticleScreen으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleScreen(article: article),
                        ),
                      );
                    },
                  ),
                  onDelete: () => _deleteNews(news), // 스와이프 시 뉴스 삭제
                );
              },
            );
          }
        },
      ),
    );
  }
}
