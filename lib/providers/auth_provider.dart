// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../config/environment.dart';
// import '../models/register.dart';
//
// class Auth with ChangeNotifier {
//   static String? _token;
//
//   bool get isAuthenticated {
//     autoLogIn();
//     return _token != null;
//   }
//
//   logOut() async {
//     _token = null;
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove('userData');
//   }
//
//   static get user async {
//     final prefs = await SharedPreferences.getInstance();
//     var res = prefs.getString('userData');
//     var result = json.decode(res!);
//     return result;
//   }
//
//   static get token async {
//     final prefs = await SharedPreferences.getInstance();
//     var res = prefs.getString('userData');
//     if (res == null) return null;
//     var result = json.decode(res);
//     _token = result['token'];
//     return _token;
//   }
//
//   autoLogIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('userData')) {
//       return false;
//     }
//     final extractedUserData = json.decode(prefs.getString('userData')!);
//     _token = extractedUserData['token'] as String?;
//     notifyListeners();
//     return true;
//   }
//
//   Future signInWithEmail(String username, String password) async {
//     String url = '${Environment().config.apiHost}api/login';
//
//     var request = await http
//         .post(Uri.parse(url), body: {"email": username, "password": password});
//     var responseData = json.decode(request.body);
//     _token = responseData['token'];
//     print(request.statusCode);
//
//     if(request.statusCode != 200) {
//       return request.statusCode;
//     }
//     // _autoLogout();
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     final userData = request.body;
//     prefs.setString('userData', userData);
//     return request.statusCode;
//   }
//
//   Future<void> registerUser(UserRegistration user) async {
//     String url = '${Environment().config.apiHost}api/register';
//
//     final response = await http.post(
//       Uri.parse(url),
//       body: jsonEncode(user.toJson()),
//     );
//
//     if (response.statusCode == 201) {
//       print('User registered successfully');
//     } else {
//       print('Failed to register user');
//     }
//   }
// }
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
  var token;
  var method;
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
        print(responseData);
        notifyListeners();
        if (response.statusCode == 200) {
          method = responseData['auth_method'];
          logged = true;
          if (responseData == null) {
            token = null;
            setAuthToken(token);
          } else {
            accessToken = responseData['token'];

            setAuthToken(accessToken);
          }

          // refreshToken = responseData['refresh_token'];
          // expireTime = responseData['expires_in'];
          // await prefs.setString('refreshToken', refreshToken);
          // await prefs.setInt('expire', expireTime!);
          // print(accessToken);
        } else {
          error = response.statusCode.toString();
        }
        return responseData;
      } catch (e) {
        error = e.toString();
      }
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

  String? _authToken;

  String? get authToken => _authToken;

  setAuthToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // _authToken = token;
    print('auth$_authToken');
    if (token == null) {
      _authToken = null;
    } else {
      await prefs.setString('accessToken', accessToken);
      _authToken = prefs.getString('accessToken');
      // await prefs.setString('auth_token', token);
    }
    print('getauth$_authToken');

    notifyListeners();
  }
}
