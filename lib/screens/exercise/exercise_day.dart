import 'package:flutter/material.dart';

import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:provider/provider.dart';
import '../../models/Excercices.dart';
import '../../provider/state_global.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ExerciseDayScreen extends StatelessWidget {
  const ExerciseDayScreen(
      {super.key,
      required this.pathJsonRoutine,
      required this.titleDay,
      required this.subTitleDay,
      required this.assetSvg1,
      required this.assetSvg2,
      required this.image,
      required this.heightImage,
      required this.rightImage,
      required this.colorContainer,
      required this.colorSvg});

  final String pathJsonRoutine;
  final String titleDay;
  final String subTitleDay;
  final String assetSvg1;
  final String assetSvg2;
  final int colorContainer;
  final int colorSvg;
  final String image;
  final double heightImage;
  final double rightImage;

  @override
  Widget build(BuildContext context) {
    List<ExercicesModel> exercises = [];
    const textStyleButton =
        TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.1);
  // final exerciceState = Provider.of<StateGlobal>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          CardDayExercice(
            colorContainer: Color(colorContainer),
            colorSvg: Color(colorSvg),
            rightImage: rightImage,
            assetSvg1: assetSvg1,
            image: image,
            assetSvg2: assetSvg2,
            heightImage: heightImage,
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
              future: getJsonExercices(pathJson: pathJsonRoutine, context: context),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ExercicesModel>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  final exercicesJson = snapshot.data as List<ExercicesModel>;
                  exercises = exercicesJson;
                  return ListExercisesContainer(exercises: exercicesJson);
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
          onPressed: () {
            AppRoutes.pushRouteCupertino(
                context: context,
                pageBuilder: RoutineStart(
                  exercices: exercises,
                ));
                
          },
          title: 'VAMOS',
          style: textStyleButton),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
