import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:bajar_de_peso_21_dias/models/Excercices.dart';
import 'package:bajar_de_peso_21_dias/share_preferences/preferences.dart';

import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../models/DayModel.dart';
import '../router/app_routes.dart';
import '../widgets/custom_button_init.dart';
import 'exercise/exercise_day.dart';

Future<List<ExercicesModel>> getJsonExercices(
    {required String pathJson, required BuildContext context}) async {
  final jsonData = await rootBundle.loadString(pathJson);
  final exercices = jsonDecode(jsonData) as List<dynamic>;

  return exercices.map((e) => ExercicesModel.fromJson(e)).toList();
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

class CardDayExercice extends StatefulWidget {
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
  State<CardDayExercice> createState() => _CardDayExerciceState();
}

class _CardDayExerciceState extends State<CardDayExercice> {
  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(20);
    final bool conditionalBlockExcercices =
        Preferences.dayActive < widget.index;
    final dayFinishedRoutine = Preferences.dayFinishedRoutine;

    void openModal() {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(now);

      if (Preferences.gameOver) {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100, bottom: 32),
                    child: const Text(
                      'Perdiste el reto',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor),
                    ),
                  ),
                  LottieBuilder.asset(
                    'assets/lotties/sad-emoji-gameover.json',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text('¡No te rindas!',
                      style: TextStyle(
                          fontSize: 25,
                          color: AppTheme.grayBlack,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    '¡Cada día es una oportunidad para mejorar y avanzar hacia tu meta de pérdida de peso!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.grayBlack,
                    ),
                  ),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                  color: AppTheme.blackLight,
                                ),
                                Text(
                                  'REGRESAR',
                                  style: TextStyle(
                                      color: AppTheme.blackLight, fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: AppTheme.grayBlack,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                'Recuperar progreso',
                                style: TextStyle(
                                    color: AppTheme.grayBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                'Para recuperar progeso se necesitan 2 Diamantes 💎',
                                style: TextStyle(color: AppTheme.blackLight),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('CANCELAR',
                                      style:
                                          TextStyle(color: AppTheme.grayBlack)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (Preferences.dimonds >= 2) {
                                      Preferences.dimonds -= 2;
                                      Preferences.dayFinishedRoutine = '';
                                      Preferences.gameOver = false;
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      setState(() {});
                                    } else {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: const Text(
                                              'Sin diamantes suficientes',
                                              style: TextStyle(
                                                  color: AppTheme.grayBlack,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: const Text(
                                              'No cuentas con diamantes sufucientes, el reto se reiniciara desde el comienzo.',
                                              style: TextStyle(
                                                  color: AppTheme.blackLight),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('CANCELAR',
                                                    style: TextStyle(
                                                        color: AppTheme
                                                            .grayBlack)),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Preferences
                                                      .dayFinishedRoutine = '';
                                                  Preferences.dayActive = 0;
                                                  Preferences.pastDay = 0;
                                                  Preferences.gameOver = false;
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: const Text('ACEPTAR',
                                                    style: TextStyle(
                                                        color: AppTheme
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ]),
                                      );
                                    }
                                  },
                                  child: const Text('RECUPERAR',
                                      style: TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                const Text(
                                  'RECUPERAR',
                                  style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Lottie.asset('assets/lotties/diamond.json',
                                    width: 30),
                              ],
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // InkWell(
                  //   child: const Text('Reiniciar'),
                  //   onTap: () {
                  //     return;
                  //     Preferences.gameOver = false;
                  //     Navigator.pop(context);
                  //   },
                  // ),
                ],
              ),
            );
          },
        );
        return;
      }
      if (dayFinishedRoutine.isEmpty) {
        widget.onTap != null ? widget.onTap!() : null;
        return;
      } else {
        //Es un ejercicio que ya hizo
        if (widget.index < Preferences.dayActive) {
          widget.onTap != null ? widget.onTap!() : null;
          return;
        }

        if (dayFinishedRoutine == formatted) {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const BreakModalExcericisesPage();
            },
          );
        } else {
          widget.onTap != null ? widget.onTap!() : null;
        }
      }
    }

    return FadeInLeft(
      duration: Duration(milliseconds: widget.durationFade),
      delay: Duration(milliseconds: widget.delayFade),
      child: InkWell(
        onTap: conditionalBlockExcercices ? null : openModal,
        borderRadius: borderRadius,
        child: Container(
          margin: const EdgeInsets.only(bottom: 17),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: widget.heightContainer,
                  decoration: BoxDecoration(
                      borderRadius: borderRadius, color: widget.colorContainer),
                ),
                positionWidget(
                  left: -150,
                  top: 10,
                  child: SvgPicture.asset(
                    widget.assetSvg1,
                    color: widget.colorSvg,
                    width: 300,
                  ),
                ),
                positionWidget(
                    child: SvgPicture.asset(
                      widget.assetSvg2,
                      color: widget.colorSvg,
                      width: 200,
                    ),
                    right: -70),
                positionWidget(
                    right: widget.rightImage,
                    top: widget.topImage,
                    bottom: widget.bottomImage,
                    left: widget.leftImage,
                    child: Image.asset(
                      widget.image,
                      height: widget.heightImage,
                    )),
                positionWidget(
                    child: _Texts(
                      title: widget.title,
                      subtitle: widget.subTitle,
                    ),
                    bottom: widget.bottomTexts,
                    left: widget.leftTexts,
                    right: widget.rightTexts,
                    top: widget.topTexts),
                if (conditionalBlockExcercices)
                  Container(
                    width: double.infinity,
                    height: widget.heightContainer,
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

class BreakModalExcericisesPage extends StatelessWidget {
  const BreakModalExcericisesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 1,
      builder: (context, scrollController) {
        return Padding(
          padding: AppTheme.paddingGeneralPages,
          child: Column(children: [
            const SizedBox(
              height: 90,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 7,
                ),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              '¡Seguimos adelante con pasión! El próximo entrenamiento puede ser el que te haga alcanzar tus metas',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            Lottie.asset('assets/lotties/time_girl.json'),
            Expanded(child: Container()),
            const Text(
              '¡Te esperamos mañana con alegría y determinación!',
              style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 27),
              textAlign: TextAlign.center,
            ),
            Expanded(child: Container()),
            CustomButtonInit(
              title: 'NOTIFICARME',
              onPressed: () {},
              style: const TextStyle(
                  fontWeight: FontWeight.w700, letterSpacing: 0.2),
            ),
            const SizedBox(
              height: 42,
            ),
          ]),
        );
      },
    );
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

// children: const [
//   Text(
//     'Quiero felicitarte por tus nuevos logros',
//     textAlign: TextAlign.center,
//     style: TextStyle(
//         color: AppTheme.grayBlack, fontWeight: FontWeight.w700),
//   ),
//   Text(
//     'una vez más demuestras que todo con esfuerzo vale mucho más la pena',
//     textAlign: TextAlign.center,
//     style: TextStyle(
//       color: AppTheme.primaryColor,
//       fontWeight: FontWeight.w700,
//     ),
//   ),
// ],
