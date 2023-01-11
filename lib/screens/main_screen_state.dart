import 'package:badges/badges.dart';
import 'package:bajar_de_peso_21_dias/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../theme/app_theme.dart';
import 'screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);

    final day = Preferences.dayFinishedRoutine == formatted
        ? Preferences.dayActive
        : Preferences.dayActive + 1;
    final List screens = [
      {'title': 'Dieta - Dia $day', 'screen': const DietScreen()},
      {'title': 'Reto - Dia $day', 'screen': const ExerciseScreen()},
      {'title': 'Ajustes', 'screen': const ProfileScreen()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          screens[currentIndex]['title'],
          style: const TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: const [Diamond()],
      ),
      body: screens[currentIndex]['screen'],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        margin: const EdgeInsets.only(bottom: 4),
        child: GNav(
            selectedIndex: currentIndex,
            iconSize: 30,
            color: AppTheme.primaryColor,
            activeColor: AppTheme.white,
            tabBackgroundColor: AppTheme.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            onTabChange: (value) {
              currentIndex = value;
              setState(() {});
            },
            gap: 12,
            duration: const Duration(milliseconds: 400),
            tabs: const [
              GButton(
                icon: Icons.restaurant,
                text: 'Dieta',
              ),
              GButton(
                icon: Icons.fitness_center,
                text: 'Ejercicios',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Ajustes',
              ),
            ]),
      ),
    );
  }
}

class Diamond extends StatelessWidget {
  const Diamond({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        color: AppTheme.primaryColor,
        fontSize: 17,
        fontWeight: FontWeight.w600);
    return Stack(
      children: [
        Lottie.asset('assets/lotties/sparklu-diamond-star-champ.json'),
        Badge(
            badgeColor: Colors.white,
            badgeContent: Text(
              Preferences.dimonds.toString(),
              style: textStyle,
            ),
            position: BadgePosition.topStart(),
            child: Lottie.asset('assets/lotties/diamond.json')),
      ],
    );
  }
}
