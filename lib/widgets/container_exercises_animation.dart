import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../theme/app_theme.dart';

class ContainerExerciseAnimation extends StatelessWidget {
  final String animation;
  final String titleExercise;
  final String duationExercise;
  const ContainerExerciseAnimation({
    Key? key,
    required this.animation,
    required this.titleExercise,
    required this.duationExercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Lottie.asset(animation, width: 120),
        const SizedBox(
          width: 12,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleExercise,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Text(
              '$duationExercise min',
              style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 16),
            ),
          ],
        )
      ],
    );
  }
}
