

import 'package:flutter/material.dart';
import 'package:reportapp/config/globalConfigUrl.dart';
import 'package:http/http.dart' as http;
import 'package:reportapp/model/Login.dart';

class AuthProvider with ChangeNotifier{
  Login loginResponse;

  Future<int> postLogin(String username, String password) async {
    final url = GlobalConfigUrl.login;
    print(url);

    final response = await http.post(
      Uri.parse(url),
      body: {
        'username': username,
        'password': password,
      },
    );
    print("post login : ${response.statusCode}");
    if (response.statusCode == 200) {
      loginResponse = loginFromJson(response.body);
    }
    return response.statusCode;
  }

}