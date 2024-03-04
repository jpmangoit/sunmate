import 'package:flutter/material.dart';
import 'package:sunmate/screens/auth/codevarificarion_page.dart';
import 'package:sunmate/screens/auth/signup_page.dart';

import '../screens/auth/login_page.dart';
import '../screens/home/getstarted.dart';
import '../screens/home/home_page.dart';

var allRoutes = {
  '/login': (BuildContext context) => LoginPage(),
  // '/Signup': (BuildContext context) => SignupPage(),
  '/verification': (BuildContext context) => CodeVerificationPage(),
  '/home': (BuildContext context) => HomePage(),
  '/firstHome': (BuildContext context) => FirstHomePage()
};
