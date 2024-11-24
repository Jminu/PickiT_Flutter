import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/article.dart';
import '../../models/product.dart';
import '../../pages/article_screen.dart';
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
      ),
      body: ListView.separated(
        itemCount: productList.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final product = productList[index];
          return GestureDetector(
            onTap: () {
              // 클릭 시 ArticleScreen으로 이동
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
            child: ProductItem(product: product), // ProductItem 위젯
          );
        },
      ),
    );
  }
}