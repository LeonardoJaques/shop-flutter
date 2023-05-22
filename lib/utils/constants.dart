import 'package:shop_flutter/models/environment.dart';

class Constants {
  static final PRODUCT_BASE_URL = '${Environment.FIREBASEAPI}/products';
  static final USER_FAVORITES = '${Environment.FIREBASEAPI}/userFavorites';
  static final ORDER_BASE_URL = '${Environment.FIREBASEAPI}/orders';
  static final FIREBASE_AUTH_SIGNUP =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${Environment.FIREBASE_AUTH_KEY}';
  static final FIREBASE_AUTH_SIGNINWITHPASSWORD =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${Environment.FIREBASE_AUTH_KEY}';
}
