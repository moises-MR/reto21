import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

// This is of first screen when user init this Aplication, only seen once
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // const steps = [FirstScreen()];
    return Scaffold(
      body: Stack(
        children: const [FirstScreenImageBackground(), ContainerBottomButton()],
      ),
    );
  }
}

class FirstScreenImageBackground extends StatelessWidget {
  const FirstScreenImageBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: const Image(
          image: AssetImage('assets/init_home_with_buttons_gradient.png'),
          fit: BoxFit.cover),
    );
  }
}

class ContainerBottomButton extends StatelessWidget {
  const ContainerBottomButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonInit(
              onPressed: () {
                Navigator.pushNamed(context, 'init_change_page');
              },
              title: 'COMENCEMOS',
              style: const TextStyle(
                  fontWeight: FontWeight.w700, letterSpacing: 0.1),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              'Acepto los Términos y Condiciones.',
              style: TextStyle(color: Color.fromARGB(220, 255, 255, 255)),
            ),
          ],
        ),
      ),
    );
  }
}
