import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/news_service.dart';
import '../../models/product.dart';
import '../../models/article.dart';
import '../Article/article_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = NewsService().fetchNews(); // Firebase에서 뉴스 데이터를 가져옴
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
      body: FutureBuilder<List<Product>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text("오류 발생: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("뉴스 데이터가 없습니다."));
          } else {
            final newsList = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                indent: 16,
                endIndent: 16,
                color: Colors.grey,
              ),
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final product = newsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleScreen(
                          article: Article(
                            title: product.title,
                            date: product.publishedAt,
                            imageUrl: product.urlToImage,
                            content: "기사 본문 내용을 여기에 추가하세요.",
                          ),
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(
                      product.urlToImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title),
                    subtitle: Text("${product.publishedAt} | ${product.address}"),
                    trailing: Text("${product.price}원"),
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
