import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class AppState extends ChangeNotifier {
  String _fontFamily = 'LINESeedJP';
  bool _isLocalFont = true;
  double _timeFontSizePortrait = 0.2;

  String get fontFamily => _fontFamily;
  bool get isLocalFont => _isLocalFont;
  double get timeFontSizePortrait => _timeFontSizePortrait;

  void setFont(String fontFamily, bool isLocal) {
    _fontFamily = fontFamily;
    _isLocalFont = isLocal;
    notifyListeners();
  }

  void setTimeFontSizePortrait(double size) {
    _timeFontSizePortrait = size;
    notifyListeners();
  }

  String _language = 'ja';

  String get language => _language;

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  bool _coffee = false;

  bool get coffee => _coffee;

  void setCoffee(bool value) {
    _coffee = value;
    if (value) {
      WakelockPlus.enable();
    } else {
      WakelockPlus.disable();
    }
    notifyListeners();
  }
}
