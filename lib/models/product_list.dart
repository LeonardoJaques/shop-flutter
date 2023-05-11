import 'package:flutter/widgets.dart';
import 'package:shop_flutter/data/dummy_data.dart';
import 'package:shop_flutter/models/products.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = DUMMY_PRODUCTS;
  List<Product> get items => [..._items];
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
