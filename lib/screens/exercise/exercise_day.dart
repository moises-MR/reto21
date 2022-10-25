import 'package:flutter/material.dart';

import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import '../../models/Excercices.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ExerciseDayScreen extends StatelessWidget {
  const ExerciseDayScreen(
      {super.key,
      required this.pathJsonRoutine,
      required this.titleDay,
      required this.subTitleDay});

  final String pathJsonRoutine;
  final String titleDay;
  final String subTitleDay;

  @override
  Widget build(BuildContext context) {
    const textStyleButton =
        TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.1);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          CardDayExercice(
            assetSvg1: 'assets/shape2.svg',
            image: 'assets/women_purple_siluet.png',
            assetSvg2: 'assets/svg.svg',
            heightImage: 300,
            heightContainer: 300,
            delayFade: 0,
            durationFade: 0,
            bottomTexts: 50,
            title: titleDay,
            subTitle: subTitleDay,
          ),
          Container(
            margin: const EdgeInsets.only(top: 307),
            child: FutureBuilder(
              future: getJsonExercices(pathJson: pathJsonRoutine),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ExercicesModel>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  final exercices = snapshot.data as List<ExercicesModel>;
                  return ListExercisesContainer(exercises: exercices);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: CustomButtonInit(
          onPressed: () => AppRoutes.pushRouteCupertino(
              context: context, pageBuilder: const RoutineStart()),
          title: 'VAMOS',
          style: textStyleButton),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
