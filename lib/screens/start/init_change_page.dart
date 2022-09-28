import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';

class InitChange extends StatelessWidget {
  const InitChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: AppTheme.blackLight,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            const TitleInitChange(),
            const SizedBox(
              height: 20,
            ),
            const ContainerImageText(),
            Expanded(child: Container()),
            CustomButtonInit(
                onPressed: () =>
                    Navigator.pushNamed(context, 'init_start_routine'),
                style: const TextStyle(
                    fontWeight: FontWeight.w800, letterSpacing: 0.1),
                title: 'COMENCEMOS'),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}

class ContainerImageText extends StatelessWidget {
  const ContainerImageText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: AppTheme.lightPink, borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IconsHeader(),
            Expanded(child: Container()),
            const TextData(),
            Expanded(child: Container()),
          ],
        ),
        const Positioned(
            right: 0,
            child: Image(
              image: AssetImage('assets/women.png'),
              fit: BoxFit.contain,
            ))
      ]),
    );
  }
}

class TextData extends StatelessWidget {
  const TextData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w800);
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pierde peso y',
            style: textStyle,
          ),
          const Text(
            'mantente en forma',
            style: textStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 200,
            height: 7,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Reto de 21 días',
            style: TextStyle(color: AppTheme.blackLight),
          )
        ],
      ),
    );
  }
}

class IconsHeader extends StatelessWidget {
  const IconsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const IconData icon = Icons.bolt;
    const double size = 30;
    const Color blackLigth = Colors.black26;
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 10),
      child: Row(
        children: const [
          Icon(icon, size: size),
          Icon(
            icon,
            color: blackLigth,
            size: size,
          ),
          Icon(
            icon,
            size: size,
            color: blackLigth,
          ),
          Icon(
            icon,
            color: blackLigth,
            size: size,
          ),
        ],
      ),
    );
  }
}

class TitleInitChange extends StatelessWidget {
  const TitleInitChange({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyleTitle = TextStyle(
        fontSize: 26,
        color: AppTheme.primaryColor,
        fontWeight: FontWeight.w700);
    return Container(
      padding: AppTheme.paddingGeneralPages,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '¡HOY EMPIEZAS A CAMBIAR!',
              style: textStyleTitle,
            ),
            Text('Tu plan está listo')
          ],
        ),
      ),
    );
  }
}
