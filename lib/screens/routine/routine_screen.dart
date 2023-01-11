import 'dart:async';

import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/screens/routine/exit_routine.dart';
import 'package:bajar_de_peso_21_dias/screens/routine/finish_routine.dart';
import 'package:bajar_de_peso_21_dias/screens/screens.dart';
import 'package:bajar_de_peso_21_dias/share_preferences/preferences.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/Excercices.dart';
import '../../provider/state_global.dart';
import '../../widgets/container_exercises_animation.dart';
import '../break/break_screen.dart';

class RotineScreen extends StatelessWidget {
  const RotineScreen({super.key, required this.exercices});
  final List<ExercicesModel> exercices;

  @override
  Widget build(BuildContext context) {
    final exerciceState = Provider.of<StateGlobal>(context);
    final seconsExecices =
        exercices[exerciceState.execiceActive].duration?.toInt() ?? 0;
    return _InitRoutine(
      exercices: exercices,
      exerciceState: exerciceState,
      seconsExecices: seconsExecices,
    );
  }
}

class _InitRoutine extends StatefulWidget {
  const _InitRoutine({
    Key? key,
    required this.exercices,
    required this.exerciceState,
    required this.seconsExecices,
  }) : super(key: key);

  final List<ExercicesModel> exercices;
  final StateGlobal exerciceState;
  final int seconsExecices;
  @override
  State<_InitRoutine> createState() => _InitRoutineState();
}

class _InitRoutineState extends State<_InitRoutine> {
  late Timer timer;
  bool timerWidgetActive = false;
  int seconsRevers = 10;

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

  void restartTimerExercices() {
    //Agregar valor que viene del ejercicio para poder reiniciarlo
    seconsRevers = 10;
    setState(() {});
  }

  void handleFinished() {
    if (timerWidgetActive) {
      timer.cancel();
      timerWidgetActive = false;
    }
    final exercicesLength = widget.exercices.length;
    if (widget.exerciceState.execiceActive + 1 <= exercicesLength - 1) {
      //Aun existen ejercicios
      AppRoutes.pushRouteCupertinoReplacementNamed(
          context: context,
          pageBuilder: BreackScreen(
            exercices: widget.exercices,
          ));
      widget.exerciceState.execiceActive++;
    } else {
      //Ya no existe ejercicios
      widget.exerciceState.execiceActive = 0;

      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(now);
      final dayFinishedRoutine = Preferences.dayFinishedRoutine;

      if (dayFinishedRoutine == formatted) {
        AppRoutes.pushRouteCupertinoReplacementNamed(
            context: context, pageBuilder: const MainScreen());
        return;
      }

      Preferences.dayFinishedRoutine = formatted;
      Preferences.dayActive++;
      Preferences.dimonds++;
      AppRoutes.pushRouteCupertinoReplacementNamed(
          context: context,
          pageBuilder: FinishScreen(
            exercices: widget.exercices,
          ));
    }
  }

  @override
  void initState() {
    seconsRevers = widget.seconsExecices;
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
      body: Column(
        children: [
          _LottieContainer(
            stopTimer: stopTimer,
            initTimer: initTimer,
            exercices: widget.exercices,
            restartTimerExercices: restartTimerExercices,
          ),
          Expanded(child: Container()),
          Text(
            widget.exercices[exerciceState.execiceActive].title.toString(),
            style: const TextStyle(
                fontSize: 27, fontWeight: FontWeight.w800, letterSpacing: 0.3),
          ),
          //
          const SizedBox(
            height: 12,
          ),

          _Counter(seconsRevers: seconsRevers),
          const SizedBox(
            height: 20,
          ),
          LinearCounter(
            seconsRevers: seconsRevers,
            stopTimer: stopTimer,
            initTimer: initTimer,
            timer: timer,
            seconsExecices: widget.seconsExecices,
          ),
          const SizedBox(
            height: 40,
          ),
          ButtonTabsBottom(
            exercices: widget.exercices,
            timer: timer,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

class ButtonTabsBottom extends StatelessWidget {
  const ButtonTabsBottom({
    Key? key,
    required this.exercices,
    required this.timer,
  }) : super(key: key);
  final List<ExercicesModel> exercices;
  final Timer timer;
  @override
  Widget build(BuildContext context) {
    final exerciceState = Provider.of<StateGlobal>(context);

    Color colorActiveBefore =
        exerciceState.execiceActive == 0 ? Colors.grey : Colors.black;
    Color colorActiveAffter =
        exerciceState.execiceActive >= exercices.length - 1
            ? Colors.grey
            : Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: exerciceState.execiceActive == 0
              ? null
              : () {
                  timer.cancel();

                  AppRoutes.pushRouteCupertinoReplacementNamed(
                      context: context,
                      pageBuilder: RotineScreen(
                        exercices: exercices,
                      ));
                  exerciceState.execiceActive--;
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.keyboard_arrow_left,
                color: colorActiveBefore,
              ),
              Text(
                'Anterior',
                style: TextStyle(color: colorActiveBefore),
              )
            ],
          ),
        ),
        Container(
          color: AppTheme.blackLight,
          height: 20,
          width: 2,
        ),
        GestureDetector(
          onTap: exerciceState.execiceActive >= exercices.length - 1
              ? null
              : () {
                  timer.cancel();
                  AppRoutes.pushRouteCupertinoReplacementNamed(
                      context: context,
                      pageBuilder: BreackScreen(
                        exercices: exercices,
                      ));
                  exerciceState.execiceActive++;
                },
          child: Row(
            children: [
              Text(
                'Siguiente',
                style: TextStyle(color: colorActiveAffter),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: colorActiveAffter,
              )
            ],
          ),
        )
      ],
    );
  }
}

String formatTimer(int seconsRevers) {
  String formatWithTwoValues(int value) => value >= 10 ? "$value" : "0$value";
  // Duration duration = Duration(milliseconds: milliseconds);
  Duration duration = Duration(seconds: seconsRevers);
  String seconds = formatWithTwoValues(duration.inSeconds.remainder(60));
  String minutes = formatWithTwoValues(duration.inMinutes);
  return "$minutes:$seconds";
}

class LinearCounter extends StatefulWidget {
  const LinearCounter({
    Key? key,
    required this.seconsRevers,
    required this.stopTimer,
    required this.initTimer,
    required this.timer,
    required this.seconsExecices,
  }) : super(key: key);

  final int seconsRevers;
  final Function stopTimer;
  final Function initTimer;
  final Timer timer;
  final int seconsExecices;
  @override
  State<LinearCounter> createState() => _LinearCounterState();
}

class _LinearCounterState extends State<LinearCounter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPause = !widget.timer.isActive;

    const textStyle = TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
    return GestureDetector(
      onTap: () {
        isPause ? widget.initTimer() : widget.stopTimer();
        setState(() {});
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: LinearProgressIndicator(
                semanticsValue: widget.seconsRevers.toString(),
                semanticsLabel: widget.seconsRevers.toString(),
                minHeight: 60,
                value: widget.seconsRevers / widget.seconsExecices,
                color: AppTheme.primaryColor,
                backgroundColor: AppTheme.lightPink,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                isPause ? Icons.play_arrow : Icons.pause,
                color: Colors.white,
                size: 25,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                isPause ? 'REANUDAR' : 'PAUSA',
                style: textStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter({
    Key? key,
    required this.seconsRevers,
  }) : super(key: key);

  final int seconsRevers;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: 'Artico',
        color: AppTheme.grayBlack);
    return Center(
      child: Text(
        formatTimer(seconsRevers),
        style: textStyle,
      ),
    );
  }
}

class _LottieContainer extends StatelessWidget {
  const _LottieContainer({
    Key? key,
    required this.stopTimer,
    required this.initTimer,
    required this.exercices,
    required this.restartTimerExercices,
  }) : super(key: key);

  final Function stopTimer;
  final Function initTimer;
  final Function restartTimerExercices;
  final List<ExercicesModel> exercices;

  @override
  Widget build(BuildContext context) {
    final exerciceState = Provider.of<StateGlobal>(context);

    void onTapArrowBackIos() {
      Navigator.push(
          context,
          AppRoutes.handleNavigate(
              pageBuilder: ExitRoutine(
                exercices: exercices,
                stopTimer: stopTimer,
                initTimer: initTimer,
                restartTimerExercices: restartTimerExercices,
              ),
              type: 'fade'));
    }

    return SizedBox(
      child: Stack(
        children: [
          Lottie.asset('assets/abdominal-crunches-exercise.json',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.50,
              fit: BoxFit.fill),
          Positioned(
              top: 73,
              left: 10,
              child: Row(
                children: [
                  GestureDetector(
                      // onTap: () => Navigator.pop(context),
                      onTap: onTapArrowBackIos,
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: AppTheme.blackLight,
                      )),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    '${exerciceState.execiceActive + 1}/${exercices.length}',
                    style: const TextStyle(
                        color: AppTheme.blackLight, fontSize: 22),
                  )
                ],
              )),
          Positioned(
              right: 12,
              top: 73,
              child: Column(
                children: [
                  _IconButton(
                    icon: Icons.videocam,
                    onPressed: () => openModal(
                      context: context,
                      initialIndex: 1,
                      radius: const Radius.circular(20),
                      animation: exercices[exerciceState.dayActive]
                          .animation_normal
                          .toString(),
                      durationExercise: exercices[exerciceState.dayActive]
                          .duration
                          .toString(),
                      titleExercise:
                          exercices[exerciceState.dayActive].title.toString(),
                      onStartTimer: initTimer,
                      onStopTimer: stopTimer,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _IconButton(
                    icon: Icons.volume_up,
                    onPressed: () {
                      initTimer();
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _IconButton(
                    icon: Icons.queue_music,
                    onPressed: () {
                      stopTimer();
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: const Color.fromARGB(40, 0, 0, 0),
          borderRadius: BorderRadius.circular(50)),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            // size: 22,
            color: Colors.white,
          )),
    );
  }
}

void openModal(
    {required BuildContext context,
    required Radius radius,
    required int initialIndex,
    required String titleExercise,
    required String animation,
    required String durationExercise,
    required Function onStartTimer,
    required Function onStopTimer}) {
  var roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: radius, topRight: radius));
  showModalBottomSheet(
      context: context,
      shape: roundedRectangleBorder,
      builder: (context) => CreateModal(
            initialIndex: initialIndex,
            titleExercise: titleExercise,
            animation: animation,
            durationExercise: durationExercise,
            onStartTimer: onStartTimer,
            onStopTimer: onStopTimer,
          ),
      isScrollControlled: true);
}
