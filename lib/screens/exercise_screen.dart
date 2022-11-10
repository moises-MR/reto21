import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:bajar_de_peso_21_dias/models/Excercices.dart';

import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import '../models/DayModel.dart';
import '../provider/state_global.dart';
import '../router/app_routes.dart';
import 'exercise/exercise_day.dart';

Future<List<ExercicesModel>> getJsonExercices(
    {required String pathJson, required BuildContext context}) async {
  final jsonData = await rootBundle.loadString(pathJson);
  final exercices = jsonDecode(jsonData) as List<dynamic>;

  return exercices.map((e) => ExercicesModel.fromJson(e)).toList();
  ;
}

Future<List<DayModel>> getJsonDays({
  required String pathJson,
}) async {
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
            //Este valor incrementa en cada iteracion del map,
            //Al no tener el index en DART tuve que hacer esto para no entretenerme
            int index = 0;
            return ListView(
              physics: AppTheme.physics,
              children: days
                  .map(
                    (day) => CardDayExercice(
                        index: index++,
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
                        onTap: () {
                          AppRoutes.pushRouteCupertino(
                              context: context,
                              pageBuilder: ExerciseDayScreen(
                                pathJsonRoutine: day.pathJsonRoutine.toString(),
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
                              ));
                        }),
                  )
                  .toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
    this.index = 0,
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
  final int index;
  final Color colorSvg;
  final Color colorContainer;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(20);
    final StateGlobal daysActive = Provider.of<StateGlobal>(context);
    final bool conditionalBlockExcercices = daysActive.dayActive < index;
    return FadeInLeft(
      duration: Duration(milliseconds: durationFade),
      delay: Duration(milliseconds: delayFade),
      child: InkWell(
        //Poner una funcion que me active un toast con una palabra de motivacion
        //Haciendo referencia a que desbloque ese logro
        //El dia sera activado hasta el dia siguiente, despues de terminar una sesion de exercicio
        //Es por eso que la funciion aparte de mandar el toast si no esta activo el dia va mostrar una alerta
        //Cuando el dia ya de haya desbloqueado Felicitando al usuario (mostrando animaciones),
        //Diciendon mensaje que espere y descanse que se desbloqueara el entrenamiento al dia siguiente despues de desbloquearlo
        onTap: conditionalBlockExcercices ? null : onTap,
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
                    top: topTexts),
                if (conditionalBlockExcercices)
                  Container(
                    width: double.infinity,
                    height: heightContainer,
                    color: AppTheme.blackLight,
                    child: Center(
                        child: SvgPicture.asset(
                      'assets/SVG/lock.svg',
                      width: 80,
                    )),
                  ),
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
