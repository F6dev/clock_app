import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'package:google_fonts/google_fonts.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    String hour = _now.hour.toString();
    String minute = _now.minute.toString().padLeft(2, '0');
    String second = _now.second.toString().padLeft(2, '0');
    String year = (_now.year % 100).toString();
    String month = _now.month.toString();
    String day = _now.day.toString();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
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
    );
  }
}
