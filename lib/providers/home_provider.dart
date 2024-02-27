import 'package:flutter/material.dart';
class HomeProvider with ChangeNotifier {
  bool isLoading = false;
  dynamic list = [];
  var token;
  var err;
  var res;
  homeApi(context) async {
    isLoading = true;


    notifyListeners();
  }
}
