import 'package:flutter/material.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'screens/screens.dart';

// import 'package:bajar_de_peso_21_dias/router/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'RETO DE 21 DIAS',
        debugShowCheckedModeBanner: false,
        // initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        home: const MainScreen(),
        // home: const StartScreen(),
        theme: AppTheme.lightTheme);
  }
}
