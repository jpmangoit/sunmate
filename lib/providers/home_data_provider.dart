import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeDataProvider extends ChangeNotifier {
  var error;
  var loader = false;
  var response;
  var token;
  var res;
  homeData(context) async {
    final pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    print('hometoken$token');
    try {
      var apiUrl = 'https://api.sunmateio.dk/dashboard/live';
      loader = true;
      notifyListeners();
      response = await http.get(
        Uri.parse(apiUrl),
        headers: {'authorization': "Bearer $token"},
      );
      loader = false;
      notifyListeners();
      if (response.statusCode == 200) {
        res = jsonDecode(response.body);

        notifyListeners();
      } else {
        error = response.body;
      }
    } catch (e) {
      error = e.toString();
    }
  }
}
