import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/environment.dart';
import '../models/login.dart';
import '../models/register.dart';

class AuthProvider extends ChangeNotifier {
  bool isLogin = false;
  bool logged = false;
  var error;
  var accessToken;
  int? expireTime;
  var refreshToken;
  UserLogin? _loginModel;
  var response;
  UserLogin? get loginModel => _loginModel;

  void updateLoginModel(UserLogin newLoginModel) {
    _loginModel = newLoginModel;
    notifyListeners();
  }

  login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_loginModel != null) {
      final apiUrl = '${Environment().config.apiHost}api/login';
      isLogin = true;
      notifyListeners();
      try {
        response = await http.post(
          Uri.parse(apiUrl),
          body: jsonEncode(_loginModel!.toJson()),
          headers: {'Content-Type': 'application/json'},
        );
        Map<String, dynamic> responseData = jsonDecode(response.body);
        isLogin = false;
        notifyListeners();
        if (response.statusCode == 200) {
          logged = true;
          accessToken = responseData['token'];
          await prefs.setString('accessToken', accessToken);

          // refreshToken = responseData['refresh_token'];
          // expireTime = responseData['expires_in'];
          // await prefs.setString('refreshToken', refreshToken);
          // await prefs.setInt('expire', expireTime!);
          // print(accessToken);
        } else {
          error = response.statusCode.toString();
        }
      } catch (e) {
        error = e.toString();
      }
      return accessToken;
    }
  }

  Future registerUser(UserRegistration user) async {
    String url = '${Environment().config.apiHost}api/register';
    final response = await http.post(
      Uri.parse(url),
      body: {
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "terms": user.terms.toString(),
        "lang": user.lang,
        "zipcode": user.zipcode
      },
    );
    var responseData = json.decode(response.body);
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      return responseData;
    }
  }

  logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
