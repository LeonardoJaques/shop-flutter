import 'package:flutter/material.dart';
import 'package:shop_flutter/components/products_item.dart';
import 'package:shop_flutter/data/dummy_data.dart';
import 'package:shop_flutter/models/products.dart';

class ProductsOverViewPage extends StatelessWidget {
  ProductsOverViewPage({super.key});
  final List<Product> loadedProducts = DUMMY_PRODUCTS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ProductItem(product: loadedProducts[i]),
      ),
    );
  }
}
