import 'package:flutter/widgets.dart';
import 'package:shop_flutter/data/dummy_data.dart';
import 'package:shop_flutter/models/products.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = DUMMY_PRODUCTS;
  // bool _showFavoriteOnly = false;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // .

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
