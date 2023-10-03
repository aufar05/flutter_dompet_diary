import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class IconDataProvider with ChangeNotifier {
  String? _iconDataString;

  String? get iconDataString => _iconDataString;

  setIconDataString(String newValue) {
    _iconDataString = newValue;
    notifyListeners();
  }
}
