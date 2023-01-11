import 'package:bajar_de_peso_21_dias/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../models/Excercices.dart';
import '../../provider/state_global.dart';
import '../routine/routine_screen.dart';

class BreackScreen extends StatelessWidget {
  const BreackScreen({super.key, required this.exercices});
  final List<ExercicesModel> exercices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mediumPink,
      body: Column(
        children: [
          Expanded(child: Container()),
          _ContainerCenter(
            exercices: exercices,
          ),
          Expanded(child: Container()),
          _BottomInfo(
            exercices: exercices,
          )
        ],
      ),
    );
  }
}

class _BottomInfo extends StatelessWidget {
  const _BottomInfo({
    Key? key,
    required this.exercices,
  }) : super(key: key);
  final List<ExercicesModel> exercices;

  @override
  Widget build(BuildContext context) {
    final exerciceState = Provider.of<StateGlobal>(context);
    const textStyle = TextStyle(
      fontSize: 17,
      color: Colors.grey,
    );
    const textStyle2 = TextStyle(
      fontSize: 19,
      color: AppTheme.primaryColor,
    );
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: exerciceState.execiceActive / exercices.length,
            backgroundColor: Colors.grey[300],
            color: AppTheme.primaryColor,
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding:
                const EdgeInsets.only(bottom: 32, left: 12, right: 12, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SIGUIENTE ${exerciceState.execiceActive + 1}/${exercices.length}',
                      style: textStyle,
                    ),
                    Text(
                      exercices[exerciceState.execiceActive].title.toString(),
                      style: const TextStyle(
                          fontSize: 19,
                          color: AppTheme.grayBlack,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      '${exercices[exerciceState.execiceActive].duration.toString()} seg.',
                      style: textStyle2,
                    ),
                  ],
                ),
                Lottie.asset(
                  exercices[exerciceState.execiceActive]
                      .animation_normal
                      .toString(),
                  width: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContainerCenter extends StatefulWidget {
  const _ContainerCenter({
    Key? key,
    required this.exercices,
  }) : super(key: key);

  final List<ExercicesModel> exercices;

  @override
  State<_ContainerCenter> createState() => _ContainerCenterState();
}

class _ContainerCenterState extends State<_ContainerCenter> {
  late Timer timer;
  bool timerWidgetActive = false;
  int seconsRevers = Preferences.breaktime;
  void initTimer() {
    if (!timerWidgetActive) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconsRevers <= 1) {
          handleFinished();
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
        handleFinished();
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

  void handleFinished() {
    if (timerWidgetActive) {
      timer.cancel();
      timerWidgetActive = true;
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
    //   print(exerciceState.execiceActive);
    const textStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 70,
        fontFamily: 'Artico');
    return FadeInDown(
      child: Center(
        child: Column(
          children: [
            const Text(
              'DESCANSO',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 22),
            ),
            Text(
              formatTimer(seconsRevers),
              style: textStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => setState(() {
                    seconsRevers += 20;
                  }),
                  child: const Chip(
                      label: Text(
                        ' +20s ',
                        style: TextStyle(
                            color: AppTheme.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      backgroundColor: Color.fromARGB(200, 255, 110, 168),
                      padding: EdgeInsets.symmetric(horizontal: 20)),
                ),
                const SizedBox(
                  width: 22,
                ),
                InkWell(
                  onTap: () => handleFinished(),
                  child: const Chip(
                      label: Text(
                        'Omitir',
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 20)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
