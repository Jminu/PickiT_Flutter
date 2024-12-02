import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Controller/GetFilteredFeeds.dart';
import '../../News.dart';
import '../../components/news_service.dart';
import '../../models/article.dart';
import '../Article/article_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<News>> _newsFuture;

  @override
  void initState() {
    super.initState();
    // 서버에서 필터링된 뉴스 데이터 가져오기
    _newsFuture = getFilteredFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 50,
              width: 125,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("검색 기능 준비 중입니다.")),
              );
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.bell),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("알림 기능 준비 중입니다.")),
              );
            },
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      body: FutureBuilder<List<News>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 에러 메시지 출력
            return Center(child: Text("오류 발생: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // 데이터가 없을 때 디버깅 출력 추가
            print("받은 데이터가 없습니다: ${snapshot.data}");
            return const Center(child: Text("뉴스 데이터가 없습니다."));
          } else {
            // 받은 데이터 디버깅용 출력
            print("받은 데이터: ${snapshot.data}");
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];

                // 뉴스 데이터 디버깅
                print(
                    "뉴스 제목: ${news.title}, 링크: ${news.link}, 발행일: ${news.published}, Img링크: ${news.imageUrl}");

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleScreen(
                          article: Article(
                            title: news.title,
                            date: news.published,
                            imageUrl: "", // 뉴스 객체에 이미지가 없는 경우
                            content: "뉴스 본문 내용을 여기에 추가하세요.",
                            url: news.link, // 뉴스의 링크를 사용
                          ),
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: news.imageUrl != null && news.imageUrl!.isNotEmpty
                        ? Image.network(
                      news.imageUrl!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.image_not_supported),
                    title: Text(news.title),
                    subtitle: Text(news.published),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

}

