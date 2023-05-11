import 'package:flutter/material.dart';
import 'package:shop_flutter/components/product_grid.dart';

class ProductsOverViewPage extends StatelessWidget {
  const ProductsOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: const ProductGrid(),
    );
  }
}
