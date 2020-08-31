import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier {
  int _themeIndex = 1;

  int get themeIndex => _themeIndex;

  String get themeName {
    if (_themeIndex == 0) {
      return "light blue";
    } else if (_themeIndex == 1) {
      return "green";
    } else if (_themeIndex == 2) {
      return "teal";
    } else if (_themeIndex == 3) {
      return "amber";
    } else if (_themeIndex == 4) {
      return "pink";
    } else if (_themeIndex == 5) {
      return "red";
    } else if (_themeIndex == 6) {
      return "blue";
    } else {
      return "indigo";
    }
  }

  setTheme(int themeIndex) {
    _themeIndex = themeIndex;
    notifyListeners();
  }
}
