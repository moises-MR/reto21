import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/screens/routine/reminder_routine.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

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
      // Navigator.push(
      //     context,
      //     AppRoutes.handleNavigate(
      //         pageBuilder: const RemeinderScreen(),
      //         type: 'bottom_fade_cupertino'));
      AppRoutes.pushRouteCupertinoReplacementNamed(
          context: context, pageBuilder: const RemeinderScreen());
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
              const _InfoFinish(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 1800),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _createColumn(title: '7', subtitle: 'Ejercicios'),
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
          children: const [
            Text(
              'FELICIDADES',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 47,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Artico'),
            ),
            Text(
              '1º DIA COMPLETADO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
