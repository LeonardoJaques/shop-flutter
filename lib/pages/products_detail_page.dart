import 'package:flutter/material.dart';
import 'package:shop_flutter/models/products.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: const Center(
        child: Text('Product Detail Page '),
      ),
    );
  }
}
