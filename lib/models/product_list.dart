import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/exception/http_exception.dart';
import 'package:shop_flutter/models/products.dart';
import 'package:shop_flutter/utils/constants.dart';

class ProductList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Product> _items = [];
  ProductList([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  final _url = Constants.PRODUCT_BASE_URL;
  final _userFavorites = Constants.USER_FAVORITES;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse('$_url.json?auth=$_token'));
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse('$_userFavorites/$_userId.json?auth=$_token'),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;

      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ),
      );
      notifyListeners();
    });
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_url.json/?auth=$_token'),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
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
        Uri.parse('$_url/${product.id}.json?auth=$_token'),
        body: jsonEncode(
          {
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
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
      final response =
          await http.delete(Uri.parse('$_url/${product.id}.json?auth=$_token'));

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
