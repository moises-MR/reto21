import 'dart:async';

import 'package:bajar_de_peso_21_dias/router/app_routes.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/widgets.dart';
import '../main_screen_state.dart';

class RemeinderScreen extends StatefulWidget {
  const RemeinderScreen({super.key});

  @override
  State<RemeinderScreen> createState() => _RemeinderScreenState();
}

class _RemeinderScreenState extends State<RemeinderScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  _open() {
    const radius =  Radius.circular(20);
    const roundedRectangleBorder = RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius));
    showModalBottomSheet(
      shape: roundedRectangleBorder,
      context: context,
      builder: (context) {
        return const _Modal();
      },
    );
  }

  @override
  void initState() {
    Timer(const Duration(milliseconds: 400), _open);

    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animateHeart() {
    if (!_controller.isAnimating) {
      _controller.value = 0;
      _controller.forward();
      _controller.isAnimating;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.asset(
            'assets/images/woman_watch2.png',
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          LottieBuilder.asset(
            'assets/lotties/hearts-feedback.json',
            repeat: false,
            controller: _controller,
            onLoaded: (animation) {
              _controller.duration = animation.duration;
            },
          ),
          SingleChildScrollView(
            physics: AppTheme.physics,
            padding: const EdgeInsets.only(top: 300),
            child: Column(
              children: [
                _ContainerReminder(
                  onTapEdit: _open,
                ),
                const SizedBox(
                  height: 22,
                ),
                _ContainerEmojis(
                  animateHeart: animateHeart,
                ),
                const SizedBox(
                  height: 22,
                ),
                const _ContainerIconsAll(),
                const SizedBox(
                  height: 22,
                ),
                const _ContainerButton(),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContainerButton extends StatelessWidget {
  const _ContainerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: CustomButtonInit(
        onPressed: () => AppRoutes.pushRouteCupertinoReplacementNamed(context: context,pageBuilder: const MainScreen()),
        title: 'TERMINAR',
        style: const TextStyle(
            fontWeight: FontWeight.bold, letterSpacing: 0.4, fontSize: 19),
      ),
    );
  }
}

class _ContainerIconsAll extends StatelessWidget {
  const _ContainerIconsAll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ContainerSvgText(
          svg: 'assets/SVG/weighing-machine.svg',
          text: '-567 Calorias',
        ),
        SizedBox(
          height: 22,
        ),
        _ContainerSvgText(
          svg: 'assets/SVG/timer.svg',
          text: '7 Minutos',
        ),
        SizedBox(
          height: 22,
        ),
        _ContainerSvgText(
          svg: 'assets/SVG/exercisewoman.svg',
          text: '12 Ejercicios',
        ),
        SizedBox(
          height: 22,
        ),
      ],
    );
  }
}

class _ContainerSvgText extends StatelessWidget {
  const _ContainerSvgText({
    Key? key,
    required this.svg,
    required this.text,
  }) : super(key: key);
  final String svg;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: decorationContainer(),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SvgPicture.asset(
          svg,
          width: 40,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600),
        )
      ]),
    );
  }
}

GestureDetector createEmojiButton(
    {required String emoji, required Function onTap, required String text}) {
  return GestureDetector(
    onTap: (() => onTap()),
    child: Column(
      children: [
        LottieBuilder.asset(
          emoji,
          width: 70,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
            color: AppTheme.grayBlack,
          ),
        )
      ],
    ),
  );
}

class _ContainerEmojis extends StatelessWidget {
  const _ContainerEmojis({super.key, required this.animateHeart});
  final Function animateHeart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: decorationContainer(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              '¿ Como te sentiste el dia de hoy ?',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Tus comentarios nos ayudan a ofrecerte entrenamientos mas adecuados para ti',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppTheme.blackLight),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              createEmojiButton(
                  emoji: 'assets/lotties/smiling-face-with-heart-eyes.json',
                  text: 'feliz',
                  onTap: animateHeart),
              createEmojiButton(
                  emoji: 'assets/lotties/face-with-rolling-eyes-emoji.json',
                  text: 'normal',
                  onTap: () {}),
              createEmojiButton(
                  emoji: 'assets/lotties/sad-face-emoji.json',
                  text: 'cansada',
                  onTap: () {}),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class _ContainerReminder extends StatelessWidget {
  const _ContainerReminder({super.key, required this.onTapEdit});
  final Function onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: decorationContainer(),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          width: 3,
          height: 40,
          color: AppTheme.primaryColor,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Recordatorio',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            Text(
              '8:00 pm',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Expanded(
            child: Container(
          height: 0,
        )),
        InkWell(
          onTap: () => onTapEdit(),
          child: const Text(
            'EDITAR',
            style: TextStyle(
                color: AppTheme.primaryColor, fontWeight: FontWeight.w600),
          ),
        )
      ]),
    );
  }
}

BoxDecoration decorationContainer() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 0,
        blurRadius: 7,
        offset: const Offset(0, 1),
      ),
    ],
  );
}

class _Modal extends StatelessWidget {
  const _Modal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  )),
            ],
          ),

          const SizedBox(
            height: 7,
          ),
          const Text(
            'Establecer recordatorio',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 7,
          ),
          // const Text('EL RETO ES CONTIGO MISMA',style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600, color: AppTheme.primaryColor),)
          const Text(
            'Todo logro empieza con la decision de intentarlo',
            style: TextStyle(
              color: AppTheme.grayBlack,
              fontSize: 17,
            ),
          ),
          const _TimePicker(),
          Expanded(child: Container()),
          CustomButtonInit(
            onPressed: () {},
            title: 'LISTO',
            style: const TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 0.4),
          ),
          const SizedBox(
            height: 37,
          )
        ],
      ),
    );
  }
}

class _TimePicker extends StatelessWidget {
  const _TimePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: double.infinity,
      height: 200,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: dateTime,
        onDateTimeChanged: (value) {
          print(value);
        },
      ),
    );
  }
}
