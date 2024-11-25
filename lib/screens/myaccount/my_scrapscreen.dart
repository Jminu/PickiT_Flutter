import 'package:flutter/material.dart';
import '../../News.dart';
import '../../UserManager.dart';
import '../../components/news_detailscreen.dart';


class MyScrapScreen extends StatefulWidget {
  final User user; // User 객체를 전달받음

  const MyScrapScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MyScrapScreenState createState() => _MyScrapScreenState();
}

class _MyScrapScreenState extends State<MyScrapScreen> {
  late Future<List<News>> _myNewsFuture;

  @override
  void initState() {
    super.initState();
    _myNewsFuture = widget.user.getMyNews(); // User 객체의 getMyNews 호출
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("스크랩한 뉴스"),
      ),
      body: FutureBuilder<List<News>>(
        future: _myNewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("오류가 발생했습니다. 다시 시도해주세요."));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("스크랩된 뉴스가 없습니다."));
          } else {
            final myNews = snapshot.data!;
            return ListView.builder(
              itemCount: myNews.length,
              itemBuilder: (context, index) {
                final news = myNews[index];
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.published),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
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
