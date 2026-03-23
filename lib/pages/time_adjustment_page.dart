import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class TimeAdjustmentPage extends StatefulWidget {
  const TimeAdjustmentPage({super.key});

  @override
  State<TimeAdjustmentPage> createState() => _TimeAdjustmentPageState();
}

class _TimeAdjustmentPageState extends State<TimeAdjustmentPage> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          appState.language == 'ja' ? 'アプリの時間の調整' : 'Time Adjustment',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text('WIP', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}