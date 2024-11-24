import 'package:flutter/material.dart';

import '../../../models/product.dart';
import 'product_detail.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 338.0,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              product.urlToImage,
              width: 405,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15.0),
          ProductDetail(product: product)
        ],
      ),
    );
  }
}
