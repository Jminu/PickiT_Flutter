import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../News.dart';
import '../../components/news_detailscreen.dart';
import '../../global.dart';

class MyScrapScreen extends StatefulWidget {
  final String? userId; //userId를 필드로 추가

  const MyScrapScreen({Key? key, this.userId}) : super(key: key);

  @override
  _MyScrapScreenState createState() => _MyScrapScreenState();
}

class _MyScrapScreenState extends State<MyScrapScreen> {
  late Future<List<News>> _myNewsFuture;

  @override
  void initState() {
    super.initState();

    // 위젯에서 전달된 userId를 사용
    String? userId = widget.userId ?? Global.getLoggedInUserId(); // 전달된 userId 또는 글로벌 ID
    if (userId != null) {
      // Firebase에서 스크랩된 뉴스 가져오기
      _myNewsFuture = Global.getMyNews(userId); // 유저 ID로 스크랩된 뉴스 호출
    } else {
      // 유저 ID가 없으면 빈 리스트 반환
      _myNewsFuture = Future.value([]); // 유저 ID가 없으면 빈 리스트 반환
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
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.published),
                  trailing: const Icon(CupertinoIcons.arrow_right),
                  onTap: () {
                    // 뉴스 상세 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(news: news),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
