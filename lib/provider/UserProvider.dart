import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reportapp/config/globalConfigUrl.dart';
import 'package:reportapp/model/UserDetail.dart';
import 'package:reportapp/model/Users.dart';
import 'package:http/http.dart' as http;

class UsersProvider with ChangeNotifier{
  Users user;
  UserDetail userDetail;
  String token = "cf08e7d006f2b613da4ca20b83a21a2b";


  Future<int> getUsers() async {
    final url = GlobalConfigUrl.users;

    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      user = usersFromJson(response.body);
      notifyListeners();
    }
    return response.statusCode;
  }

  Future<int> getUserDetail(String id) async {
    final url = GlobalConfigUrl.users + "$id";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      userDetail = userDetailFromJson(response.body);
      notifyListeners();
    }
    return response.statusCode;
  }
}