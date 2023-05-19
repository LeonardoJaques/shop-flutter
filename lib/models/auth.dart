import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/utils/constants.dart';

class Auth with ChangeNotifier {
  static final url = Constants.FIREBASE_AUTH;
  Future<void> signUp(String email, String password) async {
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
    print(jsonDecode(response.body));
  }
}
