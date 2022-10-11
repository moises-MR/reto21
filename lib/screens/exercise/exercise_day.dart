import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../exercise_screen.dart';
import '../routine/routine_screen.dart';
import '../start/start_routine.dart';

class ExerciseDayScreen extends StatelessWidget {
  const ExerciseDayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const textStyleButton =
        TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.1);
    const List exercises = [
      {
        'titleExercise': 'Abdominales',
        'animation': 'assets/abdominal-crunches-exercise.json',
        'duationExercise': '1:55'
      },
      {
        'titleExercise': 'Bir box',
        'animation': 'assets/bird_dog.json',
        'duationExercise': '0:50'
      },
      {
        'titleExercise': 'Box push up',
        'animation': 'assets/box-push-ups-exercise.json',
        'duationExercise': '1:20'
      },
      {
        'titleExercise': 'Abdominales',
        'animation': 'assets/abdominal-crunches-exercise.json',
        'duationExercise': '1:55'
      },
      {
        'titleExercise': 'Bir box',
        'animation': 'assets/bird_dog.json',
        'duationExercise': '0:50'
      },
      {
        'titleExercise': 'Box push up',
        'animation': 'assets/box-push-ups-exercise.json',
        'duationExercise': '1:20'
      },
      {
        'titleExercise': 'Plank leg up',
        'animation': 'assets/plank leg up.json',
        'duationExercise': '1:10'
      }
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Column(
        children: const [
          CardDayExercice(
            assetSvg1: 'assets/shape2.svg',
            image: 'assets/women_purple_siluet.png',
            assetSvg2: 'assets/svg.svg',
            heightImage: 300,
            heightContainer: 300,
            delayFade: 0,
            durationFade: 0,
            bottomTexts: 50,
            title: 'Dia 1',
            subTitle:
                'Entrenamientos eficientes de 3-10 min para ayudarte a perder grasa y mantenerte en forma. ¡Consigue rápido tu objetivo de pérdida de peso!',
          ),
          ListExercisesContainer(exercises: exercises),
        ],
      ),
      floatingActionButton: CustomButtonInit(
          onPressed: () => AppRoutes.pushRouteCupertino(
              context: context, pageBuilder: const RotineScreen()),
          title: 'VAMOS',
          style: textStyleButton),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
