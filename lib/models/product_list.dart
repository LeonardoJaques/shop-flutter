import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/exception/http_exception.dart';
import 'package:shop_flutter/models/environment.dart';
import 'package:shop_flutter/models/products.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = [];

  final _url = '${Environment.FIREBASEAPI}/products';

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse('$_url.json'));
    if (response.body == 'null') {
      return;
    }
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productsData) {
      _items.add(
        Product(
          id: productId,
          name: productsData['name'],
          description: productsData['description'],
          price: productsData['price'],
          imageUrl: productsData['imageUrl'],
          isFavorite: productsData['isFavorite'],
        ),
      );
      notifyListeners();
    });
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_url.json'),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      ),
    );
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null && data['id'].toString().isNotEmpty;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_url/${product.id}.json'),
        body: jsonEncode(
          {
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();
      final response = await http.delete(Uri.parse('$_url/${product.id}.json'));

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();

        throw HttpExceptionWidget(
          message: 'Ocorreu um erro na exclusão do produto.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
