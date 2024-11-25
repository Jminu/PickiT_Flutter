import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/article.dart';
import '../../models/product.dart';
import '../login/article_screen.dart';
import 'components/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          height: 0,
          indent: 16,
          endIndent: 16,
          color: Colors.grey,
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
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
            child: ProductItem(product: product),
          );
        },
      ),
    );
  }
}
