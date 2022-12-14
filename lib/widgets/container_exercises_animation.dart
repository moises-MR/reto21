import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
              // isDismissible: false,
              context: context,
              builder: (context) => CreateModal(
                    titleExercise: titleExercise,
                    animation: animation,
                    durationExercise: duationExercise,
                    onStartTimer: () {},
                    onStopTimer: () {},
                  ),
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
                    duationExercise: duationExercise),
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

class CreateModal extends StatefulWidget {
  const CreateModal({
    super.key,
    required this.titleExercise,
    required this.animation,
    required this.durationExercise,
    this.initialIndex = 0,
    required this.onStopTimer,
    required this.onStartTimer,
  });

  final String titleExercise;
  final String animation;
  final String durationExercise;
  final int initialIndex;
  final Function onStopTimer;
  final Function onStartTimer;

  @override
  State<CreateModal> createState() => _CreateModalState();
}

class _CreateModalState extends State<CreateModal> {
  @override
  void initState() {
    widget.onStopTimer();
    super.initState();
  }

  @override
  void dispose() {
    widget.onStartTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.87,
      builder: (BuildContext context, ScrollController scrollController) =>
          ContainedTabBarView(
        initialIndex: widget.initialIndex,
        tabBarViewProperties:
            const TabBarViewProperties(physics: AppTheme.physics),
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
            animation: widget.animation,
            duationExercise: widget.durationExercise,
            titleExercise: widget.titleExercise,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: _VideoPlayer(
                  titleExercise: widget.titleExercise,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12),
                child: Text(
                  widget.titleExercise,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final String titleExercise;
  const _VideoPlayer({super.key, required this.titleExercise});

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  @override
  void initState() {
    super.initState();
  }

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'uYkpTWfpFHA',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        progressIndicatorColor: AppTheme.primaryColor,
        controller: _controller,
        bottomActions: const [],
        progressColors: const ProgressBarColors(
          playedColor: AppTheme.primaryColor,
          handleColor: AppTheme.primaryColor,
        ),
      ),
      builder: (context, player) => Container(
        child: player,
      ),
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
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: AppTheme.physics,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 1,
            ),
            Lottie.asset('assets/plank leg up.json', width: double.infinity),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: Text(
                titleExercise,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Duraci??n',
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
                    'Col??cate de pie con los brazos extendidos hacia los lados a la altura de los hombros. Mueve los brazos con rapidez en grandes',
                    style: TextStyle(color: AppTheme.blackLight),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Mueve los brazos con rapidez en grandes c??rculos y en el sentido de las agujas del reloj',
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
      ),
    );
  }
}
