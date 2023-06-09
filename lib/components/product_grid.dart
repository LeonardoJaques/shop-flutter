import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/components/products_grid_item.dart';
import 'package:shop_flutter/models/product_list.dart';
import 'package:shop_flutter/models/products.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid(
    this.showFavoriteOnly, {
    super.key,
  });

  final bool showFavoriteOnly;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        // this const affects the performance of favorite button
        // ignore: prefer_const_constructors
        child: ProductGridItem(),
      ),
    );
  }
}
