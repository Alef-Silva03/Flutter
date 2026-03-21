import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor:  Colors.blue,
      brightness:  Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFE3F2FD),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 3,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      prefixIconColor: Colors.blue,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.all(Radius.circular(12))
        ),
      ),
    ),
  );
}
