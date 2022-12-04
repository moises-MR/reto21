import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _name = '';
  static String _dayFinishedRoutine = '';
  static bool _appInit = false;
  static int _dayActive = 0;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name(String name) {
    _name = name;
    _prefs.setString('name', name);
  }

  static int get dayActive {
    return _prefs.getInt('dayActive') ?? _dayActive;
  }

  static set dayActive(int value) {
    _dayActive = value;
    _prefs.setInt('dayActive', value);
  }

  static bool get appInit {
    return _prefs.getBool('appInit') ?? _appInit;
  }

  static set appInit(bool value) {
    _appInit = value;
    _prefs.setBool('appInit', value);
  }

  static String get dayFinishedRoutine {
    return _prefs.getString('dayFinishedRoutine') ?? _dayFinishedRoutine;
  }

  static set dayFinishedRoutine(String value) {
    _dayFinishedRoutine = value;
    _prefs.setString('name', value);
  }
}
