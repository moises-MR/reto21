import 'package:flutter/material.dart';

import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'start_screen';
  static final Map<String, StatelessWidget Function(BuildContext)> routes = {
    'start_screen': (BuildContext context) => const StartScreen(),
    'diet_screen': (BuildContext context) => const DietScreen(),
    'exercise_screen': (BuildContext context) => const ExerciseScreen(),
    'profile_screen': (BuildContext context) => const ProfileScreen(),
    'init_change_page': (BuildContext context) => const InitChange(),
    'init_start_routine': (BuildContext context) => const StartRoutineScreen(),
  };

  static PageRouteBuilder<dynamic> handleNavigate(
      {required Widget pageBuilder, required String type}) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            pageBuilder,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);

          if (type == 'fade') {
            return FadeTransition(
                child: child,
                opacity: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(curvedAnimation));
          }

          return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .animate(curvedAnimation),
              child: child);

          // return ScaleTransition(
          //   child: child,
          //   scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation)
          // );

          // RotationTransition
          // return RotationTransition(
          //   child: child,
          //   turns: Tween<double>(begin: 0.0, end: 1.0 ).animate(curvedAnimation)
          // );

          // return RotationTransition(
          //   child: FadeTransition(
          //     child: child,
          //     opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation)
          //   ),
          //   turns: Tween<double>(begin: 0.0, end: 1.0 ).animate(curvedAnimation)
          // );
        });
  }
}
