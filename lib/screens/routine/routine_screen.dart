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
          CircleBottom(
            controller: controller,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class CircleBottom extends StatelessWidget {
  const CircleBottom({
    Key? key,
    this.controller,
  }) : super(key: key);

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
            duration: 10,
            initialDuration: 0,
            controller: controller,
            width: 120,
            height: 120,
            ringColor: Colors.grey[300]!,
            fillColor: AppTheme.primaryColor,
            strokeWidth: 7.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold),
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
  }) : super(key: key);

  // final void Function() pauseCounterOpenModel;
  // final void Function() resumeCounterOpenModel;
  final CountDownController controller;

  

  Widget build(BuildContext context) {
    var radius = const Radius.circular(20);
    var roundedRectangleBorder = RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius));
    return Column(
      children: [
        const Text(
          'PREPARADOS',
          style: TextStyle(
              fontSize: 33, fontWeight: FontWeight.w700, letterSpacing: 0.3),
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
                  color: AppTheme.blackLight,
                  letterSpacing: 0.3),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              borderRadius: BorderRadius.all(radius),
              onTap: () {
                controller.pause();

                showModalBottomSheet(
                    context: context,
                    shape: roundedRectangleBorder,
                    builder: (context) => CreateModal(
                          titleExercise: 'Lagartijas',
                          animation: 'assets/plank leg up.json',
                          durationExercise: '10:min',
                          controller: controller,
                          
                        ),
                    isScrollControlled: true);
              },
              child: const Icon(
                Icons.help_outline_outlined,
                color: AppTheme.primaryColor,
                size: 20,
              ),
            )
          ],
        ),
      ],
    );
  }
}
