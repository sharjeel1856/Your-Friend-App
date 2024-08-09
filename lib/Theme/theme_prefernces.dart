import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const PREF_KEY = 'pref_key';
  //This methord is used to set the value of theme
  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
    // when the user select the theme the value is saved
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(PREF_KEY);
    //when the user set the theme of app first time
    //then when its come second time in the app this methord fetch
    // the vlue and show the theme accordingly
  }
}
