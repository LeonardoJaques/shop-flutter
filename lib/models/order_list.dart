import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:shop_flutter/models/cart.dart';
import 'package:shop_flutter/models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];
  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
        0,
        Order(
          id: Random().nextDouble().toString(),
          total: cart.totalAmount,
          date: DateTime.now(),
          products: cart.items.values.toList(),
        ));
    notifyListeners();
  }
}
