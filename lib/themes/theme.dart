import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.red.shade200);

ThemeData themedata = ThemeData(
  // colorScheme: kColorScheme,
  useMaterial3: true,
  fontFamily: 'Poppins',
  // colorScheme:  Colors.white,
  // unselectedWidgetColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: Colors.black),
  ),
);

ThemeData lightThemeData = ThemeData(

    primaryColor: Colors.green,
  useMaterial3: true,
  fontFamily: 'Poppins',
    brightness: Brightness.light
);

ThemeData darkThemeData = ThemeData(
  primaryColor: Colors.red,
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark
);

