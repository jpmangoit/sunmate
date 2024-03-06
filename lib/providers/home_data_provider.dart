import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../config/environment.dart';
import 'package:sunmate/providers/auth_provider.dart';

class HomeDataProvider extends ChangeNotifier {
  var error;
  var loader = false;
  var response;
  var token;
  homeData(context) async {
    token = Provider.of<AuthProvider>(context).authToken;
    print('hometoken$token');
    try {
      var apiUrl = 'https://api.sunmateio.dk/dashboard/live';
      response = http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'authorization': "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        error = response.body;
      }
    } catch (e) {
      error = e.toString();
    }
  }
}
