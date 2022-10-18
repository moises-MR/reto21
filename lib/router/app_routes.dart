import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

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
    'diet_details_screen': (BuildContext context) => const DietDetailsScreen(),
    'exercise_day_screen': (BuildContext context) => const ExerciseDayScreen(),
    'routine_screen': (BuildContext context) => const RotineScreen(),
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
          final curvedAnimation2 =
              CurvedAnimation(parent: animation, curve: Curves.easeOutSine);

          if (type == 'fade') {
            return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(curvedAnimation),
                child: child);
          }

          if (type == 'bottom_fade_cupertino') {
            return SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0), end: Offset.zero)
                    .animate(curvedAnimation2),
                child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0)
                        .animate(curvedAnimation2),
                    child: child));
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

  static Set<Future> Function(
          {required BuildContext context,
          required Widget pageBuilder}) pushRouteCupertino =
      ({required BuildContext context, required Widget pageBuilder}) => {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => pageBuilder,
                ))
          };
}
