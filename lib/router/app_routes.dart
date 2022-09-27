import 'package:flutter/material.dart';

import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'profile_screen';
  static final Map<String, StatelessWidget Function(BuildContext)> routes = {
    'diet_screen': (BuildContext context) => const DietScreen(),
    'exercise_screen': (BuildContext context) => const ExerciseScreen(),
    'profile_screen': (BuildContext context) => const ProfileScreen(),
    'init_change_page': (BuildContext context) => const InitChange(),
    'init_start_routine': (BuildContext context) => const StartRoutineScreen(),
  };
}
