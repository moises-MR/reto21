import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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

  final List screens = [
    {'title': 'Dieta - Dia 1', 'screen': const DietScreen()},
    {'title': 'Reto - Dia 1', 'screen': const ExerciseScreen()},
    {'title': 'Ajustes', 'screen': const ProfileScreen()},
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(screens[currentIndex]['title']),
        centerTitle: true,
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
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
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
