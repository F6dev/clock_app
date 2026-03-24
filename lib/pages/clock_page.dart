import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'package:google_fonts/google_fonts.dart';

class ClockPage extends StatefulWidget {
  final VoidCallback? onSettingsTap;
  const ClockPage({super.key, this.onSettingsTap});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  late DateTime _now;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  TextStyle _buildTextStyle(AppState appState, double fontSize) {
    if (appState.isLocalFont) {
      return TextStyle(
        fontFamily: appState.fontFamily,
        fontWeight: FontWeight.w100,
        color: Colors.white,
        fontSize: fontSize,
      );
    } else {
      return GoogleFonts.getFont(
        appState.fontFamily,
        color: Colors.white,
        fontSize: fontSize,
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double timeFontSize = isLandscape
        ? screenWidth * appState.timeFontSizePortrait * 0.75
        : screenWidth * appState.timeFontSizePortrait;
    double dateFontSize = isLandscape
        ? screenWidth * appState.timeFontSizePortrait * 0.5
        : screenWidth * appState.timeFontSizePortrait * 0.75;
    final appTime = appState.calcAppTime(_now);
    final parts = appTime.split(':');
    String hour = parts[0];
    String minute = parts[1];
    String second = parts[2];
    String year = (_now.year % 100).toString();
    String month = _now.month.toString();
    String day = _now.day.toString();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$hour:$minute:$second",
                  style: _buildTextStyle(appState, timeFontSize),
                ),
                Text(
                  "$year/$month/$day",
                  style: _buildTextStyle(appState, dateFontSize),
                ),
              ],
            ),
          ),
          if (isLandscape)
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => widget.onSettingsTap?.call(),
              ),
            ),
        ],
      ),
    );
  }
}
