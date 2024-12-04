import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Controller/GetFilteredFeeds.dart';
import '../../models/News.dart';
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

  Future<void> _refreshNews() async {
    setState(() {
      _newsFuture = getFilteredFeeds(); // 새 데이터를 가져오도록 상태 업데이트
    });
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
      body: RefreshIndicator(
        onRefresh: _refreshNews, // 새로고침 함수 연결
        child: FutureBuilder<List<News>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("오류 발생: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("뉴스 데이터가 없습니다."));
            } else {
              final newsList = snapshot.data!;
              return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final news = newsList[index];

                  return GestureDetector(
                    onTap: () {
                      // 클릭 시 뉴스 상세 페이지로 이동
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
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      child: Card(
                        elevation: 4, // 카드에 그림자 효과 추가
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // 둥근 모서리
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 이미지
                          // 이미지 위젯 부분
                          news.imageUrl != null && news.imageUrl!.isNotEmpty
                          ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            news.imageUrl!,
                            width: double.infinity, // 가로 전체를 채움
                            height: 180, // 이미지 크기 줄이기
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // 이미지를 가져오지 못했을 때 대체 이미지 표시
                              return Image.asset(
                                "assets/logo.png", // 대체 이미지 경로 (로고 이미지 사용)
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        )
                                  : const Icon(
                                      Icons.image_not_supported,
                                      size: 120, // 이미지가 없을 때 기본 아이콘 크기 줄이기
                                    ),
                              const SizedBox(height: 12), // 간격 줄이기

                              // 제목과 발행일
                              Text(
                                news.title,
                                style: TextStyle(
                                  fontSize: 16, // 제목 크기 줄이기
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis, // 제목이 길어지면 생략
                              ),
                              const SizedBox(height: 6), // 간격 줄이기
                              Text(
                                news.published,
                                style: TextStyle(
                                  fontSize: 12, // 발행일 크기 줄이기
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8), // 간격 줄이기

                              // 설명 부분 (내용이 있다면 표시)
                            ],
                          ),
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
