import 'dart:async';

import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/container_exercises_animation.dart';
import '../break/break_screen.dart';

class RotineScreen extends StatelessWidget {
  const RotineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CountDownController();
    return _InitRoutine(controller: controller);
  }
}

class _InitRoutine extends StatefulWidget {
  const _InitRoutine({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CountDownController controller;

  @override
  State<_InitRoutine> createState() => _InitRoutineState();
}

class _InitRoutineState extends State<_InitRoutine> {
  int milliseconds = 0;
  late Timer timer;
  bool timerWidgetActive = false;
  int seconsRevers = 10;
  void initTimer() {
    if (!timerWidgetActive) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconsRevers <= 1) {
          stopTimer();
          return;
        }
        ;
        seconsRevers--;
        setState(() {});
      });
      timerWidgetActive = true;
      return;
    }
    if (timer.isActive) return;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconsRevers <= 1) {
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

  // String formatTimer() {
  //   String formatWithTwoValues(int value) => value >= 10 ? "$value" : "0$value";
  //   Duration duration = Duration(milliseconds: milliseconds);
  //   String seconds = formatWithTwoValues(duration.inSeconds.remainder(60));
  //   String minutes = formatWithTwoValues(duration.inMinutes);
  //   return "$minutes:$seconds";
  // }

  // void changeContainer() {
  //   initTimer();
  // }

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
    return Scaffold(
      body: Column(
        children: [
          _LottieContainer(
            stopTimer: stopTimer,
            initTimer: initTimer,
          ),
          Expanded(child: Container()),
          const Text(
            'Abdominales',
            style: TextStyle(
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
          ),
          const SizedBox(
            height: 40,
          ),
          const ButtonTabsBottom(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => AppRoutes.pushRouteCupertino(
              context: context, pageBuilder: const BreackScreen()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.keyboard_arrow_left,
                color: Colors.grey,
              ),
              Text(
                'Anterior',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        Container(
          color: AppTheme.blackLight,
          height: 20,
          width: 2,
        ),
        Row(
          children: const [Text('Anterior'), Icon(Icons.keyboard_arrow_right)],
        )
      ],
    );
  }
}

class LinearCounter extends StatefulWidget {
  const LinearCounter({
    Key? key,
    required this.seconsRevers,
    required this.stopTimer,
    required this.initTimer,
  }) : super(key: key);

  final int seconsRevers;
  final Function stopTimer;
  final Function initTimer;

  @override
  State<LinearCounter> createState() => _LinearCounterState();
}

class _LinearCounterState extends State<LinearCounter> {
  bool isPause = false;
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
    return GestureDetector(
      onTap: () {
        isPause ? widget.initTimer() : widget.stopTimer();
        setState(() {
          isPause = !isPause;
        });
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
                value: widget.seconsRevers / 10,
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
    return Center(
      child: Text(
        // formatTimer(),
        '00:${seconsRevers >= 10 ? "$seconsRevers" : "0$seconsRevers"}',
        style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            fontFamily: 'Artico',
            color: AppTheme.grayBlack),
      ),
    );
  }
}

class _LottieContainer extends StatelessWidget {
  const _LottieContainer({
    Key? key,
    required this.stopTimer,
    required this.initTimer,
  }) : super(key: key);

  final Function stopTimer;
  final Function initTimer;
  @override
  Widget build(BuildContext context) {
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
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: AppTheme.blackLight,
                      )),
                  const SizedBox(
                    width: 7,
                  ),
                  const Text(
                    '1/7',
                    style: TextStyle(color: AppTheme.blackLight, fontSize: 22),
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

void openModal({
  required BuildContext context,
  required Radius radius,
  required int initialIndex,
}) {
  var roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: radius, topRight: radius));
  showModalBottomSheet(
      context: context,
      shape: roundedRectangleBorder,
      builder: (context) => CreateModal(
            initialIndex: initialIndex,
            titleExercise: 'Lagartijas',
            animation: 'assets/plank leg up.json',
            durationExercise: '10:min',
          ),
      isScrollControlled: true);
}
