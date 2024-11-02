import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void set(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void toggleTheme(index) {
    switch (index) {
      case 0:
        _themeMode = ThemeMode.light;
        break;
      case 1:
        _themeMode = ThemeMode.dark;
        break;
      case 2:
        _themeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }
}
