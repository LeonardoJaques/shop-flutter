import 'package:flutter/material.dart';
import 'package:shop_flutter/components/product_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverViewPage extends StatefulWidget {
  const ProductsOverViewPage({super.key});

  @override
  State<ProductsOverViewPage> createState() => _ProductsOverViewPageState();
}

class _ProductsOverViewPageState extends State<ProductsOverViewPage> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductList>(context);
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
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          )
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
