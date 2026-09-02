import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/core/services/shared_preference_service.dart';

class ThemeProvider with ChangeNotifier{
ThemeMode _themeMode=ThemeMode.light;
ThemeMode get themeMode=>_themeMode;
bool get isDarkMode=>_themeMode==ThemeMode.dark;
/*loadTheme start here*/
Future<void> loadTheme() async{
final isDarkMode= await SharedPreferenceService.getTheme();
_themeMode=isDarkMode?ThemeMode.dark:ThemeMode.light;
notifyListeners();
}
/*loadTheme end here*/
 /*toggleTheme start here*/
  Future<void> toggleTheme(bool isDarkMode) async{
    _themeMode=isDarkMode?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
    SharedPreferenceService.saveTheme(isDarkMode);
  }
/*toggleTheme end here*/
}