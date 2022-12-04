import 'package:bajar_de_peso_21_dias/provider/state_global.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/screens/screens.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/Excercices.dart';

class ExitRoutine extends StatefulWidget {
  const ExitRoutine(
      {super.key,
      required this.exercices,
      required this.stopTimer,
      required this.initTimer,
      required this.restartTimerExercices});
  final List<ExercicesModel> exercices;
  final Function stopTimer;
  final Function initTimer;
  final Function restartTimerExercices;
  @override
  State<ExitRoutine> createState() => _ExitRoutineState();
}

class _ExitRoutineState extends State<ExitRoutine> {
  @override
  void initState() {
    widget.stopTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (!exitRotine) widget.initTimer();
    super.dispose();
  }

  bool exitRotine = false;

  @override
  Widget build(BuildContext context) {
    final exerciceState = Provider.of<StateGlobal>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.mediumPink,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: AppTheme.paddingGeneralPages,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContainerTextLottie(
              exercices: widget.exercices,
            ),
            _Button(
              opacity: 0.2,
              text: 'Reiniciar este ejercicio',
              textColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
                widget.restartTimerExercices();
              },
            ),
            _Button(
              opacity: 0.2,
              text: 'Salir',
              textColor: Colors.white,
              onTap: () {
                exitRotine = true;
                exerciceState.execiceActive = 0;
                AppRoutes.pushRouteCupertinoReplacementNamed(
                    context: context, pageBuilder: const MainScreen());
              },
            ),
            _Button(
              opacity: 1,
              text: 'Continuar',
              textColor: AppTheme.primaryColor,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      backgroundColor: AppTheme.mediumPink,
    );
  }
}

class _ContainerTextLottie extends StatelessWidget {
  const _ContainerTextLottie({
    Key? key,
    required this.exercices,
  }) : super(key: key);

  final List<ExercicesModel> exercices;
  @override
  Widget build(BuildContext context) {
    final exerciceState = Provider.of<StateGlobal>(context);
    const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 35,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2);
    const textStyle2 = TextStyle(
      color: Colors.white,
      letterSpacing: 0.2,
      fontSize: 17,
    );
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 22),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'En Pausa',
                style: textStyle,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(exercices[exerciceState.execiceActive].title.toString(),
                  style: textStyle2)
            ],
          ),
          Expanded(child: Container()),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Lottie.asset(
              exercices[exerciceState.execiceActive]
                  .animation_normal
                  .toString(),
              width: 80,
            ),
          )
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.text,
    required this.opacity,
    required this.textColor,
    this.onTap,
  }) : super(key: key);
  final String text;
  final double opacity;
  final Color textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var borderRadius2 = BorderRadius.circular(50.0);
    return Container(
      margin: const EdgeInsets.only(top: 22),
      child: InkWell(
        borderRadius: borderRadius2,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          decoration: BoxDecoration(
              borderRadius: borderRadius2,
              color: Colors.white.withOpacity(opacity)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
