import 'package:flutter/cupertino.dart';
import 'package:your_friend/Theme/theme_prefernces.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false; //the initial value is set to be false for dark mode
  ThemePreferences _preferences = ThemePreferences();
  bool get isDark =>
      _isDark; //this is used to get the dark value or calling the dark value

  ThemeModel() {
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
    // this method is used to get the values
    // It initialize the values
    // they call get the values from shared preferences
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
    //this method is used to call the value of Dark Theme from the shared-preferences
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
    // the dark theme value will be stored in the value
    // and called through notify listener
  }
}
