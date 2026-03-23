import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String _fontFamily = 'LINESeedJP';
  bool _isLocalFont = true;
  double _timeFontSizePortrait = 0.2;
  String _language = 'ja';
  bool _coffee = false;

  String get fontFamily => _fontFamily;
  bool get isLocalFont => _isLocalFont;
  double get timeFontSizePortrait => _timeFontSizePortrait;
  String get language => _language;
  bool get coffee => _coffee;

  AppState() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _fontFamily = prefs.getString('fontFamily') ?? 'LINESeedJP';
    _isLocalFont = prefs.getBool('isLocalFont') ?? true;
    _timeFontSizePortrait = prefs.getDouble('timeFontSizePortrait') ?? 0.2;
    _language = prefs.getString('language') ?? 'ja';
    _coffee = prefs.getBool('coffee') ?? false;
    if (_coffee) WakelockPlus.enable();
    notifyListeners();
    _globalStartHour = prefs.getInt('globalStartHour') ?? 0;
    _globalStartMinute = prefs.getInt('globalStartMinute') ?? 0;
    _globalEndHour = prefs.getInt('globalEndHour') ?? 24;
    _globalEndMinute = prefs.getInt('globalEndMinute') ?? 0;
    _appStartHour = prefs.getInt('appStartHour') ?? 0;
    _appStartMinute = prefs.getInt('appStartMinute') ?? 0;
    _appEndHour = prefs.getInt('appEndHour') ?? 24;
    _appEndMinute = prefs.getInt('appEndMinute') ?? 0;
  }

  Future<void> setFont(String fontFamily, bool isLocal) async {
    _fontFamily = fontFamily;
    _isLocalFont = isLocal;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fontFamily', fontFamily);
    await prefs.setBool('isLocalFont', isLocal);
    notifyListeners();
  }

  Future<void> setTimeFontSizePortrait(double size) async {
    _timeFontSizePortrait = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('timeFontSizePortrait', size);
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    _language = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    notifyListeners();
  }

  Future<void> setCoffee(bool value) async {
    _coffee = value;
    if (value) {
      WakelockPlus.enable();
    } else {
      WakelockPlus.disable();
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('coffee', value);
    notifyListeners();
  }

  Future<void> resetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _fontFamily = 'LINESeedJP';
    _isLocalFont = true;
    _timeFontSizePortrait = 0.2;
    _language = 'ja';
    _coffee = false;
    WakelockPlus.disable();
    notifyListeners();
    _globalStartHour = 0;
    _globalStartMinute = 0;
    _globalEndHour = 24;
    _globalEndMinute = 0;
    _appStartHour = 0;
    _appStartMinute = 0;
    _appEndHour = 24;
    _appEndMinute = 0;
  }

  int _globalStartHour = 0;
  int _globalStartMinute = 0;
  int _globalEndHour = 24;
  int _globalEndMinute = 0;
  int _appStartHour = 0;
  int _appStartMinute = 0;
  int _appEndHour = 24;
  int _appEndMinute = 0;

  int get globalStartHour => _globalStartHour;
  int get globalStartMinute => _globalStartMinute;
  int get globalEndHour => _globalEndHour;
  int get globalEndMinute => _globalEndMinute;
  int get appStartHour => _appStartHour;
  int get appStartMinute => _appStartMinute;
  int get appEndHour => _appEndHour;
  int get appEndMinute => _appEndMinute;

  Future<void> setTimeAdjustment({
    int? globalStartHour,
    int? globalStartMinute,
    int? globalEndHour,
    int? globalEndMinute,
    int? appStartHour,
    int? appStartMinute,
    int? appEndHour,
    int? appEndMinute,
  }) async {
    if (globalStartHour != null) _globalStartHour = globalStartHour;
    if (globalStartMinute != null) _globalStartMinute = globalStartMinute;
    if (globalEndHour != null) _globalEndHour = globalEndHour;
    if (globalEndMinute != null) _globalEndMinute = globalEndMinute;
    if (appStartHour != null) _appStartHour = appStartHour;
    if (appStartMinute != null) _appStartMinute = appStartMinute;
    if (appEndHour != null) _appEndHour = appEndHour;
    if (appEndMinute != null) _appEndMinute = appEndMinute;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('globalStartHour', _globalStartHour);
    await prefs.setInt('globalStartMinute', _globalStartMinute);
    await prefs.setInt('globalEndHour', _globalEndHour);
    await prefs.setInt('globalEndMinute', _globalEndMinute);
    await prefs.setInt('appStartHour', _appStartHour);
    await prefs.setInt('appStartMinute', _appStartMinute);
    await prefs.setInt('appEndHour', _appEndHour);
    await prefs.setInt('appEndMinute', _appEndMinute);
    notifyListeners();
  }
}
