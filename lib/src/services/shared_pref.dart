import 'package:shared_preferences/shared_preferences.dart';

class shared_p {
  static const String PREF_NAME = "MyPreferences";
  static const String KEY_DarkMode = "name";
  static const String key_copy = "age";

  static Future<void>  setDarkmode(bool v) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KEY_DarkMode, v);
  }




  static Future<bool?> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY_DarkMode);
  }

  Future<void> setCopy(bool v) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key_copy, v);
  }

  Future<int?> getCopy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key_copy);
  }
}
