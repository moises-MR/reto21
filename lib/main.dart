import 'package:bajar_de_peso_21_dias/provider/state_global.dart';
import 'package:bajar_de_peso_21_dias/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          StateGlobal(dayActive: Preferences.dayActive),
      child: MaterialApp(
          title: 'RETO DE 21 DIAS',
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
          home: Preferences.appInit ? const MainScreen() : const StartScreen(),
          theme: AppTheme.lightTheme),
    );
  }
}
