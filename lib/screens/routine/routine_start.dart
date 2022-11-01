import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/Excercices.dart';
import '../../provider/state_global.dart';
import '../../router/app_routes.dart';
import '../../theme/app_theme.dart';
// import '../exercise/exercise_day.dart';
import 'routine_screen.dart';

class RoutineStart extends StatelessWidget {
  const RoutineStart({super.key, required this.exercices});
  final List<ExercicesModel> exercices;
  @override
  Widget build(BuildContext context) {
    return RoutineStartScreen(
      exercices: exercices,
    );
  }
}

class RoutineStartScreen extends StatefulWidget {
  const RoutineStartScreen({super.key, required this.exercices});
  final List<ExercicesModel> exercices;

  @override
  State<RoutineStartScreen> createState() => _RoutineStartScreenState();
}

class _RoutineStartScreenState extends State<RoutineStartScreen> {
  bool changeScreenActive = false;
  void changeScreen() {
    // AppRoutes.pushRouteCupertino(
    //     context: context,
    //     pageBuilder: const ExerciseDayScreen(
    //       pathJsonRoutine: 'assets/routines/day1.json',
    //       subTitleDay:
    //           'Entrenamientos eficientes de 3-10 min para ayudarte a perder grasa y mantenerte en forma. ¡Consigue rápido tu objetivo de pérdida de peso!',
    //       titleDay: 'Dia 1',
    //       assetSvg1: '',
    //       assetSvg2: '',
    //       image: '',
    //     ));
  }

  late Timer timer;
  bool timerWidgetActive = false;
  int seconsRevers = 10;
  void initTimer() {
    if (!timerWidgetActive) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconsRevers <= 1) {
          navigateNextStep();
          stopTimer();
          return;
        }
        seconsRevers--;
        setState(() {});
      });
      timerWidgetActive = true;
      return;
    }
    if (timer.isActive) return;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconsRevers <= 1) {
        navigateNextStep();
        stopTimer();
        return;
      }
      ;
      seconsRevers--;
      setState(() {});
    });
  }

  void stopTimer() {
    if (timerWidgetActive) {
      timer.cancel();
      timerWidgetActive = true;
    }
  }

  void restartTimer() {
    seconsRevers = 0;
    setState(() {});
  }

  void navigateNextStep() {
    stopTimer();
    AppRoutes.pushRouteCupertino(
        context: context,
        pageBuilder: RotineScreen(
          exercices: widget.exercices,
        ));
  }

  @override
  void initState() {
    initTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exerciceState = Provider.of<StateGlobal>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Column(
        children: [
          Lottie.asset('assets/plank leg up.json', width: double.infinity),
          const SizedBox(
            height: 40,
          ),
          _Texts(
            exercices: widget.exercices,
          ),
          Expanded(child: Container()),
          SizedBox(
            width: double.infinity,
            height: 120,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: seconsRevers / 10,
                    strokeWidth: 11,
                    backgroundColor: Colors.grey[300],
                    color: AppTheme.primaryColor,
                  ),
                ),
                Text(
                  '$seconsRevers',
                  style: const TextStyle(
                      fontFamily: 'Artico',
                      fontSize: 65,
                      color: AppTheme.grayBlack,
                      fontWeight: FontWeight.bold),
                ),
                Positioned(
                    right: 7,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          AppRoutes.pushRouteCupertino(
                              context: context,
                              pageBuilder: RotineScreen(
                                exercices: widget.exercices,
                              ));
                        },
                        child: const Icon(
                          Icons.chevron_right,
                          size: 60,
                          color: AppTheme.blackLight,
                        )))
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class _Texts extends StatelessWidget {
  const _Texts({
    Key? key,
    required this.exercices,
  }) : super(key: key);

  final List<ExercicesModel> exercices;

  Widget build(BuildContext context) {
    const radius = Radius.circular(20);
    final exerciceState = Provider.of<StateGlobal>(context);

    return Column(
      children: [
        const Text(
          'PREPARADOS',
          style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
              color: AppTheme.primaryColor),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              exercices[0].title.toString(),
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.grayBlack,
                  letterSpacing: 0.3),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              borderRadius: BorderRadius.all(radius),
              onTap: () {
                openModal(
                  radius: radius,
                  context: context,
                  initialIndex: 0,
                  animation: exercices[0].animation_normal.toString(),
                  durationExercise: exercices[0].duration.toString(),
                  titleExercise: exercices[0].title.toString(),
                );
              },
              child: const Icon(
                Icons.help_outline_outlined,
                color: AppTheme.blackLight,
                size: 24,
              ),
            )
          ],
        ),
      ],
    );
  }
}
