import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class StartRoutineScreen extends StatelessWidget {
  const StartRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
            Container(
              margin: const EdgeInsets.only(top: 22),
              padding: AppTheme.paddingPagesExercises,
              child: Column(
                children: const [
                  Text(
                    'Ejercicios',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
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
          )
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
            '1 °Dia',
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
