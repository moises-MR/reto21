import 'package:bajar_de_peso_21_dias/provider/state_global.dart';
import 'package:bajar_de_peso_21_dias/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  // sumDay(2);
  isGameOver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => StateGlobal(dayActive: 1),
      child: MaterialApp(
          title: 'RETO DE 21 DIAS',
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
          home: Preferences.appInit ? const MainScreen() : const StartScreen(),
          theme: AppTheme.lightTheme),
    );
  }
}

sumDay(int day) {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now.subtract(Duration(days: day)));
  Preferences.dayFinishedRoutine = formatted;
}

isGameOver() {
  // Preferences.dayActive = 10;
  // Preferences.pastDay = 10;
  // Preferences.gameOver = true;
  if (Preferences.dayFinishedRoutine.isEmpty) return;
  final DateTime now = DateTime.now().add(const Duration(days: 0));
  final dateToCompare =
      DateFormat('dd-MM-yyyy').parse(Preferences.dayFinishedRoutine);
  final duration = now.difference(dateToCompare);
  final days = duration.inDays;

  var daysSinceGameStart = 0;
  var gameOver = false;
  var add = [];
  var daysOfInterest = Preferences.daysOff;
  for (var i = 0; i < days; i++) {
    // Obtener el día actual
    var currentDay = DateFormat('EEEE').format(now.subtract(Duration(days: i)));

    // Verificar si el día actual está en la lista de días de tu interés
    if (!daysOfInterest.contains(currentDay)) {
      // Si no está en la lista, aumentar el contador de días transcurridos
      daysSinceGameStart++;
    }

    if (daysSinceGameStart >= 2) {
      // Si ya es el segundo dia si utilizarla PIERDES, solo se permite un dia de tolerancia
      gameOver = true;
      break;
    }
  }

  print('Han pasado - $days dias  - gameOver $gameOver');
  print('now - $now');
  print('dayFinishedRoutine - ${Preferences.dayFinishedRoutine}');
  print('daysSinceGameStart $daysSinceGameStart');
  print(Preferences.daysOff);
  print(add);
  Preferences.gameOver = gameOver;
}
