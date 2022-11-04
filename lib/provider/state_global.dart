import 'package:flutter/material.dart';

class StateGlobal with ChangeNotifier {
  int _dayActive = 0;
  final List<int> _elapsedDays = [0];
  int _execiceActive = 0;

  int get dayActive => _dayActive;
  int get execiceActive => _execiceActive;
  List<int> get elapsedDays => _elapsedDays;

  set dayActive(int day) {
    _dayActive = day;
    notifyListeners();
  }

  set execiceActive(int value) {
    _execiceActive = value;
    notifyListeners();
  }

  elapsedDaysAdd(int day) {
    _elapsedDays.add(day);
    notifyListeners();
  }
}
