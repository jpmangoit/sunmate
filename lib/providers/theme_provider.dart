import 'package:flutter/material.dart';

import '../themes/theme.dart';

enum ThemeMode { light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightThemeData;
  ThemeMode _themeMode = ThemeMode.light;

  ThemeData getTheme() => _themeData;
  ThemeMode getThemeMode() => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _themeData = _themeMode == ThemeMode.light ? lightThemeData : darkThemeData;
    notifyListeners();
  }
}
