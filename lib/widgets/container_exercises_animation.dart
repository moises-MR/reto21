import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../theme/app_theme.dart';

class ContainerExerciseAnimation extends StatelessWidget {
  final String animation;
  final String titleExercise;
  final String duationExercise;
  const ContainerExerciseAnimation({
    Key? key,
    required this.animation,
    required this.titleExercise,
    required this.duationExercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 250),
      delay: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: () {
          var radius = const Radius.circular(20);
          var roundedRectangleBorder = RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(topLeft: radius, topRight: radius));
          showModalBottomSheet(
              context: context,
              builder: (context) => _createModal(
                  titleExercise: titleExercise,
                  animation: animation,
                  durationExercise: duationExercise),
              shape: roundedRectangleBorder,
              isScrollControlled: true);
        },
        child: Column(
          children: [
            Row(
              children: [
                Lottie.asset(animation, width: 120),
                const SizedBox(
                  width: 12,
                ),
                _Texts(
                    titleExercise: titleExercise,
                    duationExercise: duationExercise)
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}

class _Texts extends StatelessWidget {
  const _Texts({
    Key? key,
    required this.titleExercise,
    required this.duationExercise,
  }) : super(key: key);

  final String titleExercise;
  final String duationExercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleExercise,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        Text(
          '$duationExercise min',
          style: const TextStyle(color: AppTheme.primaryColor, fontSize: 16),
        ),
      ],
    );
  }
}

Widget _createModal(
    {required String titleExercise,
    required String animation,
    required String durationExercise}) {
  return DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.87,
    builder: (BuildContext context, ScrollController scrollController) =>
        ContainedTabBarView(
      tabBarProperties: const TabBarProperties(
        labelColor: Colors.black,
        indicatorColor: AppTheme.primaryColor,
      ),
      tabs: const [
        Text('Animacion'),
        Text('Video'),
      ],
      views: [
        ViewAnimation(
          animation: animation,
          duationExercise: durationExercise,
          titleExercise: titleExercise,
        ),
        const _VideoPlayer(
          titleExercise: 'Bir box',
        )
      ],
      onChange: (index) => print(index),
    ),
  );
}

class _VideoPlayer extends StatelessWidget {
  final String titleExercise;
  const _VideoPlayer({super.key, required this.titleExercise});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 1,
        ),
        Container(color: Colors.black, height: 250, child: newMethod()),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 12),
          child: Text(
            titleExercise,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Center newMethod() {
    return const Center(
        child: SpinKitFadingCircle(
      size: 100,
      color: AppTheme.primaryColor,
    ));
  }
}

class ViewAnimation extends StatelessWidget {
  final String animation;
  final String titleExercise;
  final String duationExercise;
  const ViewAnimation({
    Key? key,
    required this.animation,
    required this.titleExercise,
    required this.duationExercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AppTheme.physics,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 1,
          ),
          Lottie.asset(animation, width: double.infinity),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: Text(
              titleExercise,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Divider(),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Duración',
                  style: TextStyle(),
                ),
                Text(duationExercise,
                    style: const TextStyle(color: AppTheme.primaryColor)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Column(
              children: const [
                //TODO Las instrucciones de uso son una lista de String aqui esta hardcode
                Text(
                  'Colócate de pie con los brazos extendidos hacia los lados a la altura de los hombros. Mueve los brazos con rapidez en grandes',
                  style: TextStyle(color: AppTheme.blackLight),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Mueve los brazos con rapidez en grandes círculos y en el sentido de las agujas del reloj',
                  style: TextStyle(color: AppTheme.blackLight),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
