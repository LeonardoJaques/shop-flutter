import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/components/product_grid.dart';
import 'package:shop_flutter/models/product_list.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverViewPage extends StatelessWidget {
  const ProductsOverViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorites) {
                provider.showFavoriteOnly();
              } else {
                provider.showAll();
              }
            },
          )
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
