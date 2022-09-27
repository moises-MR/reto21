import 'package:flutter/material.dart';

class AppTheme {
  /* COLORS */
  static const Color primaryColor = Color.fromARGB(255, 255, 73, 144);
  static const Color lightPink = Color(0xffffebee);
  static const Color blackLight = Colors.black45;
  static const Color white = Colors.white;
  /* PADDINGS GENERAL */
  static const EdgeInsetsGeometry paddingGeneralPages = EdgeInsets.all(12);
  static const EdgeInsetsGeometry paddingPagesExercises = EdgeInsets.symmetric(horizontal: 20);

  // static const Color primaryColor = Colors.indigoAccent;ff6da6

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      appBarTheme:
          const AppBarTheme(backgroundColor: primaryColor, elevation: 0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: primaryColor,
          selectedItemColor: white,
          elevation: 0),
      scaffoldBackgroundColor: white);
}
