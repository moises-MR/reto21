import 'package:bajar_de_peso_21_dias/provider/state_global.dart';
import 'package:flutter/material.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => StateGlobal(),
      child: MaterialApp(
          title: 'RETO DE 21 DIAS',
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
          home: const MainScreen(),
          // home: const StartScreen(),
          theme: AppTheme.lightTheme),
    );
  }
}
