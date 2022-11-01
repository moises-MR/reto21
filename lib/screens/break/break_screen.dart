import 'package:animate_do/animate_do.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/Excercices.dart';
import '../../provider/state_global.dart';
import '../routine/finish_routine.dart';
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
          const _ContainerCenter(),
          Expanded(child: Container()),
          InkWell(
              onTap: () => AppRoutes.pushRouteCupertino(
                  context: context, pageBuilder: FinishScreen()),
              child: _BottomInfo(
                exercices: exercices,
              )),
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

    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: 0.2,
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
                    const Text(
                      'SIGUIENTE 2/6',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      exercices[exerciceState.dayActive + 1].title.toString(),
                      style: const TextStyle(
                          fontSize: 19,
                          color: AppTheme.grayBlack,
                          fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        openModal(
                          radius: const Radius.circular(20),
                          context: context,
                          initialIndex: 0,
                          animation: exercices[exerciceState.dayActive]
                              .animation_normal
                              .toString(),
                          durationExercise: exercices[exerciceState.dayActive]
                              .duration
                              .toString(),
                          titleExercise: exercices[exerciceState.dayActive]
                              .title
                              .toString(),
                        );
                      },
                      child: const Icon(
                        Icons.help_outline_outlined,
                        color: AppTheme.blackLight,
                        size: 24,
                      ),
                    ),
                    const Text(
                      '00:20',
                      style: TextStyle(
                        fontSize: 19,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                LottieBuilder.asset(
                  'assets/lotties/abdominales_crunch_blank.json',
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

class _ContainerCenter extends StatelessWidget {
  const _ContainerCenter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Text(
              '00:28',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 70,
                  fontFamily: 'Artico'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Chip(
                    label: Text(
                      '+20s',
                      style: TextStyle(
                          color: AppTheme.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    backgroundColor: Color.fromARGB(200, 255, 110, 168),
                    padding: EdgeInsets.symmetric(horizontal: 20)),
                SizedBox(
                  width: 22,
                ),
                Chip(
                    label: Text(
                      'Omitir',
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 20)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
