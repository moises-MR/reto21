import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:bajar_de_peso_21_dias/models/Excercices.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/screens/routine/reminder_routine.dart';
import 'package:bajar_de_peso_21_dias/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key, required this.exercices});
  final List<ExercicesModel> exercices;

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), onCloseDialog);
    super.initState();
  }

  void onCloseDialog() {
    if (mounted) {
      AppRoutes.pushRouteCupertinoReplacementNamed(
          context: context,
          pageBuilder: RemeinderScreen(
            exercices: widget.exercices,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(
            'assets/images/finish_routine.png',
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              LottieBuilder.asset(
                'assets/lotties/trophy.json',
                repeat: false,
                width: 300,
                height: 300,
              ),
              const _Texts(),
              Expanded(child: Container()),
              _InfoFinish(
                exercices: widget.exercices,
              ),
              const SizedBox(
                height: 70,
              )
            ],
          ),
          Positioned(
              top: 0,
              child: LottieBuilder.asset(
                repeat: false,
                'assets/lotties/success.json',
                height: MediaQuery.of(context).size.height,
              )),
        ],
      ),
    );
  }
}

class _InfoFinish extends StatelessWidget {
  const _InfoFinish({
    Key? key,
    required this.exercices,
  }) : super(key: key);
  final List<ExercicesModel> exercices;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 1800),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _createColumn(
              title: exercices.length.toString(), subtitle: 'Ejercicios'),
          _createColumn(title: '6.6', subtitle: 'Calorías'),
          _createColumn(title: '00:55', subtitle: 'Duración'),
        ],
      ),
    );
  }

  Column _createColumn({required String title, required String subtitle}) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 27, fontFamily: 'Artico'),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

class _Texts extends StatelessWidget {
  const _Texts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        delay: const Duration(milliseconds: 1000),
        child: Column(
          children: [
            const Text(
              'FELICIDADES',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 47,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Artico'),
            ),
            Text(
              '${Preferences.dayActive}º DIA COMPLETADO',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
