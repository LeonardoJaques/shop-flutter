import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/components/app_drawer.dart';
import 'package:shop_flutter/components/products_item.dart';
import 'package:shop_flutter/models/product_list.dart';
import 'package:shop_flutter/utils/app_route.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCTS_FORM);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) => Column(children: [
                  ProductItem(products.items[i]),
                  const Divider(),
                ])),
      ),
    );
  }
}
