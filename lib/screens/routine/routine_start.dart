import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../theme/app_theme.dart';
import '../../widgets/container_exercises_animation.dart';
import '../exercise/exercise_day.dart';
import 'routine_screen.dart';

class RoutineStart extends StatelessWidget {
  const RoutineStart({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoutineStartScreen();
  }
}

class RoutineStartScreen extends StatefulWidget {
  const RoutineStartScreen({super.key});

  @override
  State<RoutineStartScreen> createState() => _RoutineStartScreenState();
}

class _RoutineStartScreenState extends State<RoutineStartScreen> {
  bool changeScreenActive = false;
  void changeScreen() {
    AppRoutes.pushRouteCupertino(
        context: context,
        pageBuilder: const ExerciseDayScreen(
          pathJsonRoutine: 'assets/routines/day1.json',
          subTitleDay:
              'Entrenamientos eficientes de 3-10 min para ayudarte a perder grasa y mantenerte en forma. ¡Consigue rápido tu objetivo de pérdida de peso!',
          titleDay: 'Dia 1',
        ));
  }

  @override
  Widget build(BuildContext context) {
    final controller = CountDownController();
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
            controller: controller,
          ),
          Expanded(child: Container()),
          _CircleBottom(
            controller: controller,
            changeScreen: changeScreen,
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
    required this.controller,
  }) : super(key: key);

  final CountDownController controller;

  Widget build(BuildContext context) {
    var radius = const Radius.circular(20);

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
            const Text(
              'LAGARTIJAS',
              style: TextStyle(
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
                _openModal(
                  radius: radius,
                  context: context,
                  initTimer: () {},
                  initialIndex: 0,
                  stopTimer: () {},
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

class _CircleBottom extends StatelessWidget {
  const _CircleBottom({
    Key? key,
    required this.controller,
    required this.changeScreen,
  }) : super(key: key);
  final Function changeScreen;

  final CountDownController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: [
          CircularCountDownTimer(
            onChange: (value) {
              if (value == '6') {}
            },
            duration: 10,
            initialDuration: 0,
            controller: controller,
            width: 130,
            height: 130,
            ringColor: Colors.grey[300]!,
            fillColor: AppTheme.primaryColor,
            strokeWidth: 10.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontFamily: 'Artico',
                fontSize: 65,
                color: AppTheme.grayBlack,
                fontWeight: FontWeight.bold),
            isReverse: true,
            isReverseAnimation: true,
            isTimerTextShown: true,
            autoStart: true,
          ),
          Positioned(
              right: 7,
              child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => AppRoutes.pushRouteCupertino(
                      context: context, pageBuilder: const RotineScreen()),
                  child: const Icon(
                    Icons.chevron_right,
                    size: 60,
                    color: AppTheme.blackLight,
                  )))
        ],
      ),
    );
  }
}

void _openModal(
    {required BuildContext context,
    required Radius radius,
    required Function initTimer,
    required int initialIndex,
    required Function stopTimer}) {
  var roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: radius, topRight: radius));
  stopTimer();
  showModalBottomSheet(
      context: context,
      shape: roundedRectangleBorder,
      builder: (context) => CreateModal(
            initialIndex: initialIndex,
            titleExercise: 'Lagartijas',
            animation: 'assets/plank leg up.json',
            durationExercise: '10:min',
            stopTimer: () {},
            initTimer: initTimer,
          ),
      isScrollControlled: true);
}
