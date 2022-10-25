import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:bajar_de_peso_21_dias/models/Excercices.dart';

import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/DayModel.dart';
import '../router/app_routes.dart';
import 'exercise/exercise_day.dart';

Future<List<ExercicesModel>> getJsonExercices(
    {required String pathJson}) async {
  final jsonData = await rootBundle.loadString(pathJson);
  final exercices = jsonDecode(jsonData) as List<dynamic>;
  return exercices.map((e) => ExercicesModel.fromJson(e)).toList();
}

Future<List<DayModel>> getJsonDays({required String pathJson}) async {
  final jsonData = await rootBundle.loadString(pathJson);
  final days = jsonDecode(jsonData) as List<dynamic>;
  return days.map((e) => DayModel.fromJson(e)).toList();
}

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: AppTheme.paddingGeneralPages,
      child: SingleChildScrollView(
        physics: AppTheme.physics,
        child: FutureBuilder(
          future: getJsonDays(pathJson: 'assets/days/days.json'),
          builder:
              (BuildContext context, AsyncSnapshot<List<DayModel>> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final days = snapshot.data as List<DayModel>;
              return SingleChildScrollView(
                child: Column(
                  children: days
                      .map(
                        (day) => CardDayExercice(
                            title: 'Dia ${day.day} - ${day.title}',
                            subTitle: day.subTitle.toString(),
                            assetSvg1: day.assetSvg1.toString(),
                            image: day.image ?? '',
                            assetSvg2: day.assetSvg2.toString(),
                            heightImage: day.heightImage,
                            rightImage: day.rightImage,
                            colorContainer:
                                Color(int.parse(day.colorContainer.toString())),
                            colorSvg: Color(int.parse(day.colorSvg.toString())),
                            onTap: () => AppRoutes.pushRouteCupertino(
                                context: context,
                                pageBuilder: ExerciseDayScreen(
                                  pathJsonRoutine:
                                      day.pathJsonRoutine.toString(),
                                  subTitleDay: day.subTitleDay.toString(),
                                  titleDay: 'Dia ${day.day}',
                                  assetSvg1: day.assetSvg1.toString(),
                                  assetSvg2: day.assetSvg2.toString(),
                                  image: day.image.toString(),
                                  heightImage:
                                      double.parse(day.heightImage.toString()),
                                  rightImage:
                                      double.parse(day.rightImage.toString()),
                                  colorContainer:
                                      int.parse(day.colorContainer.toString()),
                                  colorSvg: int.parse(day.colorSvg.toString()),
                                ))),
                      )
                      .toList(),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    ));
  }
}

class CardDayExercice extends StatelessWidget {
  const CardDayExercice({
    Key? key,
    required this.assetSvg1,
    required this.assetSvg2,
    required this.image,
    this.colorSvg = const Color(0xffffe0ff),
    this.colorContainer = const Color(0xfffef0ff),
    this.topImage,
    this.bottomImage,
    this.leftImage,
    this.rightImage = 0.0,
    this.heightImage = 150,
    this.heightContainer = 150,
    this.durationFade = 250,
    this.delayFade = 200,
    this.topTexts,
    this.bottomTexts,
    this.leftTexts,
    this.rightTexts,
    this.onTap,
    this.title = '',
    this.subTitle = '',
  }) : super(key: key);

  final String assetSvg1;
  final String image;
  final String title;
  final String subTitle;
  final String assetSvg2;
  final double? topImage;
  final double? bottomImage;
  final double? leftImage;
  final double? rightImage;
  final double? topTexts;
  final double? bottomTexts;
  final double? leftTexts;
  final double? rightTexts;
  final double? heightImage;
  final double? heightContainer;
  final void Function()? onTap;
  final int durationFade;
  final int delayFade;
  final Color colorSvg;
  final Color colorContainer;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(20);
    return FadeInLeft(
      duration: Duration(milliseconds: durationFade),
      delay: Duration(milliseconds: delayFade),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          margin: const EdgeInsets.only(bottom: 17),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: heightContainer,
                  decoration: BoxDecoration(
                      borderRadius: borderRadius, color: colorContainer),
                ),
                positionWidget(
                  left: -150,
                  top: 10,
                  child: SvgPicture.asset(
                    assetSvg1,
                    color: colorSvg,
                    width: 300,
                  ),
                ),
                positionWidget(
                    child: SvgPicture.asset(
                      assetSvg2,
                      color: colorSvg,
                      width: 200,
                    ),
                    right: -70),
                positionWidget(
                    right: rightImage,
                    top: topImage,
                    bottom: bottomImage,
                    left: leftImage,
                    child: Image.asset(
                      image,
                      height: heightImage,
                    )),
                positionWidget(
                    child: _Texts(
                      title: title,
                      subtitle: subTitle,
                    ),
                    bottom: bottomTexts,
                    left: leftTexts,
                    right: rightTexts,
                    top: topTexts)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned positionWidget({
    required Widget child,
    double? right,
    double? top,
    double? left,
    double? bottom,
  }) {
    return Positioned(
        right: right, left: left, top: top, bottom: bottom, child: child);
  }
}

class _Texts extends StatelessWidget {
  const _Texts({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          const SizedBox(
            height: 4,
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }
}



// [
//           CardDayExercice(
//             title: 'Dia 1 - Entrenamiento de abdominales',
//             subTitle: 'Ejercicios adominales',
//             assetSvg1: 'assets/shape2.svg',
//             image: 'assets/women_purple_siluet.png',
//             assetSvg2: 'assets/svg.svg',
//             heightImage: 300,
          //   onTap: () => AppRoutes.pushRouteCupertino(
          //       context: context,
          //       pageBuilder: const ExerciseDayScreen(
          //         pathJsonRoutine: 'assets/routines/day1.json',
          //         subTitleDay: 'Entrenamientos eficientes de 3-10 min para ayudarte a perder grasa y mantenerte en forma. ¡Consigue rápido tu objetivo de pérdida de peso!',
          //         titleDay: 'Dia 1',
          //       )),
          // ),
//           const SizedBox(
//             height: 20,
//           ),

//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape.svg',
//           //   image: 'assets/women-yoga.png',
//           //   assetSvg2: 'assets/shape2.1.svg',
//           //   colorContainer: Color(0xffe2f9ff),
//           //   colorSvg: Color(0xffc0f1ff),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape3.svg',
//           //   image: 'assets/women_days/women-day3.png',
//           //   assetSvg2: 'assets/shape3-1.svg',
//           //   colorContainer: Color(0xfff0fefe),
//           //   colorSvg: Color(0xffcef7e9),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape5.svg',
//           //   image: 'assets/women_days/women-day4.png',
//           //   assetSvg2: 'assets/shape5-1.svg',
//           //   colorContainer: Color(0xffecf6ff),
//           //   colorSvg: Color(0xffadddff),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape6.svg',
//           //   image: 'assets/women_days/women-day5.png',
//           //   assetSvg2: 'assets/shape6.svg',
//           //   colorContainer: Color(0xffecedff),
//           //   colorSvg: Color(0xffccd4ff),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape2.svg',
//           //   image: 'assets/women_purple_siluet.png',
//           //   assetSvg2: 'assets/svg.svg',
//           //   heightImage: 300,
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape.svg',
//           //   image: 'assets/women-yoga.png',
//           //   assetSvg2: 'assets/shape2.1.svg',
//           //   colorContainer: Color(0xffe2f9ff),
//           //   colorSvg: Color(0xffc0f1ff),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape3.svg',
//           //   image: 'assets/women_days/women-day3.png',
//           //   assetSvg2: 'assets/shape3-1.svg',
//           //   colorContainer: Color(0xfff0fefe),
//           //   colorSvg: Color(0xffcef7e9),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape5.svg',
//           //   image: 'assets/women_days/women-day4.png',
//           //   assetSvg2: 'assets/shape5-1.svg',
//           //   colorContainer: Color(0xffecf6ff),
//           //   colorSvg: Color(0xffadddff),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape6.svg',
//           //   image: 'assets/women_days/women-day5.png',
//           //   assetSvg2: 'assets/shape6.svg',
//           //   colorContainer: Color(0xffecedff),
//           //   colorSvg: Color(0xffccd4ff),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape2.svg',
//           //   image: 'assets/women_purple_siluet.png',
//           //   assetSvg2: 'assets/svg.svg',
//           //   heightImage: 300,
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape.svg',
//           //   image: 'assets/women-yoga.png',
//           //   assetSvg2: 'assets/shape2.1.svg',
//           //   colorContainer: Color(0xffe2f9ff),
//           //   colorSvg: Color(0xffc0f1ff),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape3.svg',
//           //   image: 'assets/women_days/women-day3.png',
//           //   assetSvg2: 'assets/shape3-1.svg',
//           //   colorContainer: Color(0xfff0fefe),
//           //   colorSvg: Color(0xffcef7e9),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape5.svg',
//           //   image: 'assets/women_days/women-day4.png',
//           //   assetSvg2: 'assets/shape5-1.svg',
//           //   colorContainer: Color(0xffecf6ff),
//           //   colorSvg: Color(0xffadddff),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // CardDayExercice(
//           //   assetSvg1: 'assets/shape6.svg',
//           //   image: 'assets/women_days/women-day5.png',
//           //   assetSvg2: 'assets/shape6.svg',
//           //   colorContainer: Color(0xffecedff),
//           //   colorSvg: Color(0xffccd4ff),
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//         ]