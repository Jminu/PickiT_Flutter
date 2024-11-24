import 'package:flutter/material.dart';

import '../../../models/article.dart';
import '../../../models/product.dart';
import '../../login/article_screen.dart';


class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        height: 135.0,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                product.urlToImage,
                width: 115,
                height: 115,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4.0),
                  Text('${product.address} • ${product.publishedAt}', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4.0),
                  Text('${product.price}원', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}