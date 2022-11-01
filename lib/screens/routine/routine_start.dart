import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/Excercices.dart';
import '../../provider/state_global.dart';
import '../../router/app_routes.dart';
import '../../theme/app_theme.dart';
// import '../exercise/exercise_day.dart';
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
  void changeScreen() {
    // AppRoutes.pushRouteCupertino(
    //     context: context,
    //     pageBuilder: const ExerciseDayScreen(
    //       pathJsonRoutine: 'assets/routines/day1.json',
    //       subTitleDay:
    //           'Entrenamientos eficientes de 3-10 min para ayudarte a perder grasa y mantenerte en forma. ¡Consigue rápido tu objetivo de pérdida de peso!',
    //       titleDay: 'Dia 1',
    //       assetSvg1: '',
    //       assetSvg2: '',
    //       image: '',
    //     ));
  }

  @override
  Widget build(BuildContext context) {
  final exerciceState = Provider.of<StateGlobal>(context);

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
                
                // Cambiarlo el value a un timer
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 10),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (BuildContext context, double value, Widget? child) {
                    return SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 11,
                        backgroundColor: Colors.grey[300],
                        color: AppTheme.primaryColor,
                      ),
                    );
                  },
                ),
                const Text('0', style: TextStyle(
                fontFamily: 'Artico',
                fontSize: 65,
                color: AppTheme.grayBlack,
                fontWeight: FontWeight.bold),),
                Positioned(
                    right: 7,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          AppRoutes.pushRouteCupertino(
                            context: context,
                            pageBuilder:  RotineScreen(exercices: widget.exercices,));
                            exerciceState.execiceActive++;
                        },
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
    var radius = const Radius.circular(20);

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
              // exerciceState.excercices[0].title.toString(),
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

// class _CircleBottom extends StatelessWidget {
//   const _CircleBottom({
//     Key? key,
//     required this.controller,
//     required this.changeScreen,
//   }) : super(key: key);
//   final Function changeScreen;

//   final CountDownController controller;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Stack(
//         alignment: AlignmentDirectional.center,
//         clipBehavior: Clip.none,
//         children: [
//           CircularCountDownTimer(
//             onChange: (value) {
//               if (value == '6') {}
//             },
//             duration: 10,
//             initialDuration: 0,
//             controller: controller,
//             width: 130,
//             height: 130,
//             ringColor: Colors.grey[300]!,
//             fillColor: AppTheme.primaryColor,
//             strokeWidth: 10.0,
//             strokeCap: StrokeCap.round,
//             textStyle: const TextStyle(
//                 fontFamily: 'Artico',
//                 fontSize: 65,
//                 color: AppTheme.grayBlack,
//                 fontWeight: FontWeight.bold),
//             isReverse: true,
//             isReverseAnimation: true,
//             isTimerTextShown: true,
//             autoStart: true,
//           ),
//           Positioned(
//               right: 7,
//               child: InkWell(
//                   borderRadius: BorderRadius.circular(100),
//                   onTap: () => AppRoutes.pushRouteCupertino(
//                       context: context, pageBuilder: const RotineScreen()),
//                   child: const Icon(
//                     Icons.chevron_right,
//                     size: 60,
//                     color: AppTheme.blackLight,
//                   )))
//         ],
//       ),
//     );
//   }
// }

// void _openModal(
//     {required BuildContext context,
//     required Radius radius,
//     required Function initTimer,
//     required int initialIndex,
//     required Function stopTimer}) {
//   var roundedRectangleBorder = RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(topLeft: radius, topRight: radius));
//   stopTimer();
//   showModalBottomSheet(
//       context: context,
//       shape: roundedRectangleBorder,
//       builder: (context) => CreateModal(
//             initialIndex: initialIndex,
//             titleExercise: 'Lagartijas',
//             animation: 'assets/plank leg up.json',
//             durationExercise: '10:min',
//           ),
//       isScrollControlled: true);
// }
