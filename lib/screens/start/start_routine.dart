import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class StartRoutineScreen extends StatelessWidget {
  const StartRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    const textStyleButton =
        TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.1);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.blackLight,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppTheme.lightPink,
            height: 300,
            width: double.infinity,
            child: Stack(
              children: const [
                Positioned(
                  right: 0,
                  child: Image(image: AssetImage('assets/women.png')),
                ),
                ContainerTextWihOutImage(),
              ],
            ),
          ),
          const Instructions(),
          const ListExercisesContainer(exercises: exercises),
        ],
      ),
      floatingActionButton: CustomButtonInit(
          onPressed: () => Navigator.push(context, AppRoutes.handleNavigate(pageBuilder: const MainScreen(), type: 'fade')),
          title: 'VAMOS',
          style: textStyleButton),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

class ListExercisesContainer extends StatelessWidget {
  const ListExercisesContainer({
    Key? key,
    required this.exercises,
  }) : super(key: key);

  final List exercises;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 22, bottom: 22),
        padding: AppTheme.paddingPagesExercises,
        child: SingleChildScrollView(
          physics: AppTheme.physics,
          child: Column(
            children: exercises
                .map((e) => ContainerExerciseAnimation(
                      animation: e['animation'],
                      duationExercise: e['duationExercise'],
                      titleExercise: e['titleExercise'],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class Instructions extends StatelessWidget {
  const Instructions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.paddingPagesExercises,
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Instrucciones',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            'Entrenamientos eficientes de 3-10 min para ayudarte a perder grasa y mantenerte en forma. ¡Consigue rápido tu objetivo de pérdida de peso!',
            style: TextStyle(color: AppTheme.blackLight),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Ejercicios',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerTextWihOutImage extends StatelessWidget {
  const ContainerTextWihOutImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container()),
          const Text(
            '1° Dia',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const Text('4 Mins - 8 ejercicios'),
          const Chip(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
            ),
            label: Text(
              'Hazlo posible',
              style: TextStyle(color: Color.fromARGB(174, 255, 73, 143)),
            ),
            avatar: Icon(
              Icons.tips_and_updates,
              color: Color.fromARGB(174, 255, 73, 143),
            ),
            backgroundColor: Colors.white,
          )
        ],
      ),
    );
  }
}
