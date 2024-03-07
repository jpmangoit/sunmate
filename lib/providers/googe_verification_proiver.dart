import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunmate/providers/auth_provider.dart';

import '../config/environment.dart';

class GoogleVerificationProvider extends ChangeNotifier {
  var response, res, err, method;
  googleVerification(code, context) async {
    final pref = await SharedPreferences.getInstance();
    method = pref.getString('method');
    print(method);
    var token = Provider.of<AuthProvider>(context, listen: false).authToken;
    print(token);
    var apiUrl = '${Environment().config.apiHost}api/verification-mfa';
    try {
      response = await http.post(Uri.parse(apiUrl),
          headers: {'authorization': "Bearer $token"},
          body: {"auth_method": method, "one_time_password": code});

      res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if(res['token']) {
          await pref.setString('token', res['token']);
        }
        return res;
      } else {
        return res;
      }

    } catch (e) {
      err = e.toString();
    }
  }
}
