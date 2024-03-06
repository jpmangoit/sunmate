import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sunmate/providers/auth_provider.dart';

import '../config/environment.dart';

class GoogleVerificationProvider extends ChangeNotifier {
  var response;
  googleVerification(code, context) async {
    var token = Provider.of<AuthProvider>(context, listen: false).authToken;
    print(token);
    var apiUrl = '${Environment().config.apiHost}api/verification-mfa';
    try {
      response = await http.post(Uri.parse(apiUrl),
          headers: {'authorization': "Bearer $token"},
          body: {"auth_method": "google", "one_time_password": code});
      print(response);
      print(jsonDecode(response.body));
      print(response.body);
      return response.body;
    } catch (e) {}
  }
}