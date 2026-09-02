import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService{
  static const String _themeKey="isDarkMode";
  /*saveTheme start here*/
static Future<void> saveTheme(bool isDarkMode) async {
final prefs= await SharedPreferences.getInstance();
await prefs.setBool(_themeKey, isDarkMode);
}
/*saveTheme end here*/
/*saveTheme start here*/
  static Future<bool> getTheme() async {
    final prefs= await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey)??false;
  }
/*saveTheme end here*/
}