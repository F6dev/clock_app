import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'dart:async';

class TimeAdjustmentPage extends StatefulWidget {
  const TimeAdjustmentPage({super.key});

  @override
  State<TimeAdjustmentPage> createState() => _TimeAdjustmentPageState();
}

class _TimeAdjustmentPageState extends State<TimeAdjustmentPage> {
  late TextEditingController _gStartHourController;
  late TextEditingController _gStartMinuteController;
  late TextEditingController _gEndHourController;
  late TextEditingController _gEndMinuteController;
  late TextEditingController _aStartHourController;
  late TextEditingController _aStartMinuteController;
  late TextEditingController _aEndHourController;
  late TextEditingController _aEndMinuteController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    final appState = context.read<AppState>();
    _gStartHourController = TextEditingController(
      text: appState.globalStartHour.toString(),
    );
    _gStartMinuteController = TextEditingController(
      text: appState.globalStartMinute.toString().padLeft(2, '0'),
    );
    _gEndHourController = TextEditingController(
      text: appState.globalEndHour.toString(),
    );
    _gEndMinuteController = TextEditingController(
      text: appState.globalEndMinute.toString().padLeft(2, '0'),
    );
    _aStartHourController = TextEditingController(
      text: appState.appStartHour.toString(),
    );
    _aStartMinuteController = TextEditingController(
      text: appState.appStartMinute.toString().padLeft(2, '0'),
    );
    _aEndHourController = TextEditingController(
      text: appState.appEndHour.toString(),
    );
    _aEndMinuteController = TextEditingController(
      text: appState.appEndMinute.toString().padLeft(2, '0'),
    );
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _gStartHourController.dispose();
    _gStartMinuteController.dispose();
    _gEndHourController.dispose();
    _gEndMinuteController.dispose();
    _aStartHourController.dispose();
    _aStartMinuteController.dispose();
    _aEndHourController.dispose();
    _aEndMinuteController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _save(AppState appState) {
    appState.setTimeAdjustment(
      globalStartHour: int.tryParse(_gStartHourController.text) ?? 0,
      globalStartMinute: int.tryParse(_gStartMinuteController.text) ?? 0,
      globalEndHour: int.tryParse(_gEndHourController.text) ?? 24,
      globalEndMinute: int.tryParse(_gEndMinuteController.text) ?? 0,
      appStartHour: int.tryParse(_aStartHourController.text) ?? 0,
      appStartMinute: int.tryParse(_aStartMinuteController.text) ?? 0,
      appEndHour: int.tryParse(_aEndHourController.text) ?? 24,
      appEndMinute: int.tryParse(_aEndMinuteController.text) ?? 0,
    );
  }

  Widget _timeInput(
    String label,
    TextEditingController hourController,
    TextEditingController minuteController,
    AppState appState,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 60,
            child: TextField(
              controller: hourController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(color: Colors.white, fontSize: 24),
              decoration: const InputDecoration(
                hintText: '0',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (_) => _save(appState),
            ),
          ),
          const Text(
            ' : ',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(
            width: 60,
            child: TextField(
              controller: minuteController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(color: Colors.white, fontSize: 24),
              decoration: const InputDecoration(
                hintText: '00',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (_) => _save(appState),
            ),
          ),
        ],
      ),
    );
  }

  String _calcAppTime(AppState appState) {
    final now = DateTime.now();
    final gStartSec =
        appState.globalStartHour * 3600 + appState.globalStartMinute * 60;
    final gEndSec =
        appState.globalEndHour * 3600 + appState.globalEndMinute * 60;
    final aStartSec =
        appState.appStartHour * 3600 + appState.appStartMinute * 60;
    final aEndSec = appState.appEndHour * 3600 + appState.appEndMinute * 60;
    final nowSec = now.hour * 3600 + now.minute * 60 + now.second;
    final gDaySec = gEndSec - gStartSec;
    final aDaySec = aEndSec - aStartSec;
    if (gDaySec <= 0) return '--:--:--';
    final elapsed = nowSec - gStartSec;
    final aElapsed = (elapsed * aDaySec / gDaySec).round();
    final aTotalSec = aStartSec + aElapsed;
    final aHour = aTotalSec ~/ 3600;
    final aMinute = (aTotalSec % 3600) ~/ 60;
    final aSecond = aTotalSec % 60;
    return '$aHour:${aMinute.toString().padLeft(2, '0')}:${aSecond.toString().padLeft(2, '0')}';
  }

  double _calcRate(AppState appState) {
    final gStartSec =
        appState.globalStartHour * 3600 + appState.globalStartMinute * 60;
    final gEndSec =
        appState.globalEndHour * 3600 + appState.globalEndMinute * 60;
    final aStartSec =
        appState.appStartHour * 3600 + appState.appStartMinute * 60;
    final aEndSec = appState.appEndHour * 3600 + appState.appEndMinute * 60;
    final gDaySec = gEndSec - gStartSec;
    final aDaySec = aEndSec - aStartSec;
    if (gDaySec <= 0) return 1.0;
    return aDaySec / gDaySec;
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final now = DateTime.now();
    final rate = _calcRate(appState);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            appState.language == 'ja' ? 'アプリの時間の調整' : 'Time Adjustment',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}  →  ${_calcAppTime(appState)}',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Speed: x${rate.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                appState.language == 'ja' ? 'グローバル' : 'Global',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            _timeInput(
              appState.language == 'ja' ? '開始' : 'Start',
              _gStartHourController,
              _gStartMinuteController,
              appState,
            ),
            _timeInput(
              appState.language == 'ja' ? '終了' : 'End',
              _gEndHourController,
              _gEndMinuteController,
              appState,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                appState.language == 'ja' ? 'アプリ' : 'App',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            _timeInput(
              appState.language == 'ja' ? '開始' : 'Start',
              _aStartHourController,
              _aStartMinuteController,
              appState,
            ),
            _timeInput(
              appState.language == 'ja' ? '終了' : 'End',
              _aEndHourController,
              _aEndMinuteController,
              appState,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () {
                      _save(appState);
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: Text(appState.language == 'ja' ? '決定' : 'Done'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _gStartHourController.text = '0';
                        _gStartMinuteController.text = '00';
                        _gEndHourController.text = '24';
                        _gEndMinuteController.text = '00';
                        _aStartHourController.text = '0';
                        _aStartMinuteController.text = '00';
                        _aEndHourController.text = '24';
                        _aEndMinuteController.text = '00';
                      });
                      _save(appState);
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                    child: Text(appState.language == 'ja' ? 'リセット' : 'Reset'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
