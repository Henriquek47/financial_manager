import 'package:financial_manager/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  Brightness _brightness = Brightness.light;

  Brightness get brightness => _brightness;


  set themeData(ThemeData themeData){
    _themeData = themeData;
    _brightness = themeData.brightness;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
      _brightness = Brightness.dark;
    } else{
      themeData = lightMode;
      _brightness = Brightness.light;
    }
  }
}

extension ThemeModeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}