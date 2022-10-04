import 'package:flutter/material.dart';

class AppTheme {
  /* COLORS */
  static const Color primaryColor = Color(0xffFF4990);
  static const Color lightPink = Color(0xffffebee);
  static const Color blackLight = Colors.black45;
  static const Color white = Colors.white;
  /* PADDINGS GENERAL */
  static const EdgeInsetsGeometry paddingGeneralPages = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsetsGeometry paddingPagesExercises =
      EdgeInsets.only(left: 20, right: 20);
  /* PHYSICS SCROLL */
  static const ScrollPhysics physics =
      BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  // static const Color primaryColor = Colors.indigoAccent;ff6da6

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: primaryColor, elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryColor, selectedItemColor: white, elevation: 0),
    scaffoldBackgroundColor: white,
  );
}
