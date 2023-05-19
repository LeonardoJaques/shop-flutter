import 'package:shop_flutter/models/environment.dart';

class Constants {
  static final PRODUCT_BASE_URL = '${Environment.FIREBASEAPI}/products';
  static final ORDER_BASE_URL = '${Environment.FIREBASEAPI}/orders';
  static final FIREBASE_AUTH =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${Environment.FIREBASE_AUTH_KEY}';
}
