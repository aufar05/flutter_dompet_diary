import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkModeEnabled = false;

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  void toggleDarkMode(bool newValue) {
    _isDarkModeEnabled = newValue;
    notifyListeners();
  }
}
