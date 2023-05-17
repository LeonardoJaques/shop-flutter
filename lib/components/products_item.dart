import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/exception/http_exception.dart';
import 'package:shop_flutter/models/product_list.dart';
import 'package:shop_flutter/models/products.dart';
import 'package:shop_flutter/utils/app_route.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final message = ScaffoldMessenger.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCTS_FORM,
                arguments: product,
              );
            },
            icon: const Icon(Icons.edit),
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            onPressed: () {
              showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Excluir produto'),
                  content: const Text('Tem certeza?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Não'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Sim'),
                    ),
                  ],
                ),
              ).then((value) async {
                if (value ?? false) {
                  try {
                    await Provider.of<ProductList>(context, listen: false)
                        .removeProduct(product);
                  } on HttpExceptionWidget catch (onError) {
                    message.showSnackBar(
                      SnackBar(content: Text(onError.toString())),
                    );
                  }
                }
              });
            },
            icon: const Icon(Icons.delete),
            color: Theme.of(context).colorScheme.error,
          ),
        ]),
      ),
    );
  }
}
