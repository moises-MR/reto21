import 'dart:async';

import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/container_exercises_animation.dart';

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


  void initTimer() {
    if(!timerWidgetActive){
      print('milliseconds == 0');
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      milliseconds += 100;
      setState(() {});
    });
    timerWidgetActive = true;
    return;
    }
    if (timer.isActive) return;
      print('timer.is no tActive');

    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      milliseconds += 100;
      setState(() {});
    });
  }

  void stopTimer() {
    if (milliseconds != 0) timer.cancel();
  }

  void restartTimer() {
    milliseconds = 0;
    setState(() {});
  }

  String formatTimer() {
    String formatWithTwoValues(int value) => value >= 10 ? "$value" : "0$value";
    Duration duration = Duration(milliseconds: milliseconds);
    String seconds = formatWithTwoValues(duration.inSeconds.remainder(60));
    String minutes = formatWithTwoValues(duration.inMinutes);
    return "$minutes:$seconds";
  }

  void changeContainer () {
    initTimer();    
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  final conuter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _LottieContainer(
            controller: widget.controller,
            stopTimer: stopTimer,
          ),
          const SizedBox(
            height: 40,
          ),
          _Texts(
            controller: widget.controller,
            stopTimer: stopTimer,
          ),
          Expanded(child: Container()), 
         
          CircleBottom(
            controller: widget.controller, changeContainer: changeContainer,
          ) ,
          Center(
            child: Text(
              formatTimer(),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
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

class _LottieContainer extends StatelessWidget {
  const _LottieContainer({
    Key? key,
    required this.controller,
    required this.stopTimer,
  }) : super(key: key);

  final CountDownController controller;
  final Function stopTimer;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Lottie.asset('assets/plank leg up.json', width: double.infinity),
          Positioned(
              top: 73,
              left: 10,
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: AppTheme.blackLight,
                  ))),
          Positioned(
              right: 12,
              top: 73,
              child: Column(
                children: [
                  _IconButton(
                    icon: Icons.videocam,
                    onPressed: () => openModal(context,
                        const Radius.circular(20), controller, 1, stopTimer),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _IconButton(
                    icon: Icons.volume_up,
                    onPressed: () {
                      print('object');
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _IconButton(
                    icon: Icons.queue_music,
                    onPressed: () {
                      print('object');
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

class CircleBottom extends StatelessWidget {
  const CircleBottom({
    Key? key,
    this.controller, required this.changeContainer,
  }) : super(key: key);
  final Function changeContainer;
  final CountDownController? controller;

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
              if(value == '9') changeContainer();
            },
            duration: 10,
            initialDuration: 0,
            controller: controller,
            width: 140,
            height: 140,
            ringColor: Colors.grey[300]!,
            fillColor: AppTheme.primaryColor,
            strokeWidth: 10.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 80,
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
                  onTap: () => {},
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

class _Texts extends StatelessWidget {
  const _Texts({
    Key? key,
    required this.controller,
    required this.stopTimer,
  }) : super(key: key);

  final Function stopTimer;
  final CountDownController controller;

  Widget build(BuildContext context) {
    var radius = const Radius.circular(20);

    return Column(
      children: [
        const Text(
          'PREPARADOS',
          style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.w700,
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
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 0.3),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              borderRadius: BorderRadius.all(radius),
              onTap: () {
                openModal(
                  context,
                  radius,
                  controller,
                  0,
                  stopTimer,
                );
              },
              child: const Icon(
                Icons.help_outline_outlined,
                color: AppTheme.grayBlack,
                size: 24,
              ),
            )
          ],
        ),
      ],
    );
  }
}

void openModal(BuildContext context, Radius radius,
    CountDownController controller, int initialIndex, Function stopTimer) {
  var roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: radius, topRight: radius));
  if (controller.isStarted) controller.pause();

  showModalBottomSheet(
      context: context,
      shape: roundedRectangleBorder,
      builder: (context) => CreateModal(
            initialIndex: initialIndex,
            titleExercise: 'Lagartijas',
            animation: 'assets/plank leg up.json',
            durationExercise: '10:min',
            controller: controller,
            stopTimer: stopTimer,
          ),
      isScrollControlled: true);
}
