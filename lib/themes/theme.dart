import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.red.shade200);


ThemeData lightThemeData = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
    brightness: Brightness.light
);

ThemeData darkThemeData = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark
);

