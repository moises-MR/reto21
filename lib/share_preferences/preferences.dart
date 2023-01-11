import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _name = '';
  static List<String> _daysOff = [
    // 'Saturday',
    // 'Friday',
    // 'Thursday',
    // 'Wednesday',
    'Tuesday',
    'Monday',
    'Sunday'
  ];
  static String _dayFinishedRoutine = '';
  static bool _appInit = false;
  static bool _gameOver = false;
  static int _dayActive = 0;
  static int _pastDay = 0;
  static int _dimonds = 0;
  static int _breaktime = 30;

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

  static int get dimonds {
    return _prefs.getInt('dimonds') ?? _dimonds;
  }

  static set dimonds(int value) {
    _dimonds = value;
    _prefs.setInt('dimonds', value);
  }

  static int get breaktime {
    return _prefs.getInt('breaktime') ?? _breaktime;
  }

  static set breaktime(int value) {
    _breaktime = value;
    _prefs.setInt('breaktime', value);
  }

  static int get pastDay {
    return _prefs.getInt('pastDay') ?? _pastDay;
  }

  static set pastDay(int value) {
    _pastDay = value;
    _prefs.setInt('pastDay', value);
  }

  static bool get appInit {
    return _prefs.getBool('appInit') ?? _appInit;
  }

  static set appInit(bool value) {
    _appInit = value;
    _prefs.setBool('appInit', value);
  }

  static bool get gameOver {
    return _prefs.getBool('gameOver') ?? _gameOver;
  }

  static set gameOver(bool value) {
    _gameOver = value;
    _prefs.setBool('gameOver', value);
  }

  static String get dayFinishedRoutine {
    return _prefs.getString('dayFinishedRoutine') ?? _dayFinishedRoutine;
  }

  static set dayFinishedRoutine(String value) {
    _dayFinishedRoutine = value;
    _prefs.setString('dayFinishedRoutine', value);
  }

  static List<String> get daysOff {
    return _prefs.getStringList('daysOff') ?? _daysOff;
  }

  static set daysOff(List<String> value) {
    _daysOff = value;
    _prefs.setStringList('daysOff', value);
  }
}
