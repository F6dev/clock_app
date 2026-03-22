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
  }
}
