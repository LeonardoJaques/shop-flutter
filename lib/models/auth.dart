import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/exception/auth_exception.dart';
import 'package:shop_flutter/utils/constants.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uId;
  String? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate != null
        ? DateTime.now().isBefore(DateTime.parse(_expiryDate!))
        : false;
    return _token != null && isValid;
  }

  String? get token => isAuth ? _token : null;
  String? get email => isAuth ? _email : null;
  String? get uId => isAuth ? _uId : null;

  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url = urlFragment.contains('signUp')
        ? Constants.FIREBASE_AUTH_SIGNUP
        : Constants.FIREBASE_AUTH_SIGNINWITHPASSWORD;

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uId = body['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(body['expiresIn'])))
          .toString();
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'login');
  }
}
//https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
//https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]
