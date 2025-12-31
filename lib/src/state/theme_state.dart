import 'package:flutter/material.dart';

class ThemeState extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void setDark(bool value) {
    if (_isDark == value) {
      return;
    }
    _isDark = value;
    notifyListeners();
  }
}
