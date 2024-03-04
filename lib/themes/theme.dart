import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';

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

