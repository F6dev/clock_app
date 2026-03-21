import 'package:flutter/material.dart';

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
}