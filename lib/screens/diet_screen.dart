import 'package:animate_do/animate_do.dart';
import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button_init.dart';
import 'diet/diet_details.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ContainerSlide(),
      ],
    ));
  }
}

class ContainerSlide extends StatelessWidget {
  const ContainerSlide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> images = [
      "assets/meal.jpeg",
      "assets/meal.jpeg",
      "assets/meal.jpeg",
      "assets/meal.jpeg",
    ];

    final customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
      ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
      ..addTranslate([
        const Offset(-370.0, -50.0),
        const Offset(0.0, 0.0),
        const Offset(370.0, -40.0)
      ]);

    return SizedBox(
      width: double.infinity,
      height: 440,
      child: Swiper(
        physics: AppTheme.physics,
        customLayoutOption: customLayoutOption,
        itemBuilder: (BuildContext context, int index) {
          const borderRadius = BorderRadius.all(Radius.circular(20));
          return Hero(
            tag: 'diet-image$index',
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    image: DecorationImage(
                        image: AssetImage(images[index]), fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  bottom: 33,
                  child: CustomButtonInit(
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, letterSpacing: .3),
                    onPressed: () => AppRoutes.pushRouteCupertino(
                        context: context,
                        pageBuilder: const DietDetailsScreen()),
                    // Navigator.pushNamed(context, 'diet_details_screen'),
                    title: 'VAMOS',
                  ),
                ),
                if (index != 0)
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppTheme.blackLight,
                        borderRadius: borderRadius,
                      ),
                      child: const Icon(
                        Icons.lock_rounded,
                        color: Colors.white,
                        size: 150,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        itemCount: images.length,
        // layout: SwiperLayout.STACK,
        loop: false,
        viewportFraction: 0.85,
        scale: 0.9,
      ),
    );
  }
}
