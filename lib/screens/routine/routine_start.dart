import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

import '../../models/Excercices.dart';
import '../../router/app_routes.dart';
import '../../theme/app_theme.dart';
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

  late Timer timer;
  bool timerWidgetActive = false;
  int seconsRevers = 10;

  void initTimer() {
    if (!timerWidgetActive) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconsRevers <= 1) {
          navigateNextStep();
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
      timerWidgetActive = false;
    }
  }

  void restartTimer() {
    seconsRevers = 0;
    setState(() {});
  }

  void navigateNextStep() {
      if (timerWidgetActive) {
      timer.cancel();
      timerWidgetActive = false;
    }
    AppRoutes.pushRouteCupertinoReplacementNamed(
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
    // final exerciceState = Provider.of<StateGlobal>(context);

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
                        onTap: () => navigateNextStep(),
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
    // final exerciceState = Provider.of<StateGlobal>(context);

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
