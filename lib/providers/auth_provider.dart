import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/environment.dart';
import '../models/register.dart';

class Auth with ChangeNotifier {
  static String? _token;

  bool get isAuthenticated {
    autoLogIn();
    return _token != null;
  }

  logOut() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  static get user async {
    final prefs = await SharedPreferences.getInstance();
    var res = prefs.getString('userData');
    var result = json.decode(res!);
    return result;
  }

  static get token async {
    final prefs = await SharedPreferences.getInstance();
    var res = prefs.getString('userData');
    if (res == null) return null;
    var result = json.decode(res);
    _token = result['token'];
    return _token;
  }

  autoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')!);
    _token = extractedUserData['token'] as String?;
    notifyListeners();
    return true;
  }

  Future signInWithEmail(String username, String password) async {
    String url = '${Environment().config.apiHost}api/login';

    var request = await http
        .post(Uri.parse(url), body: {"email": username, "password": password});
    var responseData = json.decode(request.body);
    _token = responseData['token'];
    print(request.statusCode);

    if(request.statusCode != 200) {
      return request.statusCode;
    }
    // _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = request.body;
    prefs.setString('userData', userData);
    return request.statusCode;
  }

  Future<void> registerUser(UserRegistration user) async {
    String url = '${Environment().config.apiHost}api/register';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      print('User registered successfully');
    } else {
      print('Failed to register user');
    }
  }
}
