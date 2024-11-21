import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Kodchasan',
  brightness: Brightness.light,
  primaryColor: const Color(0xFF60B3DD),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF60B3DD),
    brightness: Brightness.light,
  ).copyWith(
    secondary: const Color(0xFF354C76),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF60B3DD),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
);

ThemeData darkMode = ThemeData(
  fontFamily: 'Kodchasan',
  brightness: Brightness.dark,
  
  primaryColor: const Color(0xFF354C76),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF354C76),
    brightness: Brightness.dark,
  ).copyWith(
    secondary: const Color(0xFF60B3DD),
  ),

  // Outras Configurações
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor:  Color(0xFF181818),
  ),
  scaffoldBackgroundColor: const Color(0xFF181818),
);
