import 'package:animate_do/animate_do.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DietDetailsScreen extends StatelessWidget {
  const DietDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 248, 250, 251),
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Column(
            children: [
              const _HeaderImage(),
              Expanded(
                child: ListView(
                  physics: AppTheme.physics,
                  children: [
                    // Hacerlo con builder separator
                    const _ContainerText(
                      assetSvg: 'assets/SVG/breakfast.svg',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 70),
                      child: const Divider(
                        height: 2,
                      ),
                    ),
                    const _ContainerText(
                      assetSvg: 'assets/SVG/fitness.svg',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 70),
                      child: const Divider(
                        height: 2,
                      ),
                    ),
                    const _ContainerText(
                      assetSvg: 'assets/SVG/meal.svg',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 70),
                      child: const Divider(
                        height: 2,
                      ),
                    ),
                    const _ContainerText(
                      assetSvg: 'assets/SVG/dinner-time.svg',
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class _ContainerText extends StatelessWidget {
  const _ContainerText({
    Key? key,
    required this.assetSvg,
  }) : super(key: key);
  final String assetSvg;
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Container(
        padding: AppTheme.paddingGeneralPages,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(7)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    assetSvg,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Desayuno',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.primaryColor),
                  )
                ],
              ),
              const _Ingredient(
                title: '1 taza de té o café negro sin azúcar ni leche',
              ),
              const _Ingredient(
                title: 'Gachas de avena',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Ingredient extends StatelessWidget {
  const _Ingredient({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 7),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromARGB(255, 194, 191, 191)),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20);
    final boxDecoration = BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('assets/meal.jpeg'), fit: BoxFit.fill),
        borderRadius:
            const BorderRadius.only(bottomLeft: radius, bottomRight: radius),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 20,
              offset: const Offset(0, 20))
        ]);
    return Hero(
      tag: 'diet-image0',
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: boxDecoration,
      ),
    );
  }
}
