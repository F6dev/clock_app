import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  // アプリの起動時に実行
  runApp(const MyApp()); // MyAppクラスをアプリとして起動
}

class MyApp extends StatelessWidget {
  // MyAppというクラスを、StatelessWidgetを継承して作る
  const MyApp({super.key}); // アプリを初期化

  @override
  Widget build(BuildContext context) {
    // 画面を描画
    return const MaterialApp(home: ClockPage()); // ClockPageクラスを実行
  }
}

class ClockPage extends StatefulWidget {
  // アプリの本体を、StatefulWidgetを継承して作る
  const ClockPage({super.key}); // ページを初期化

  @override
  State<ClockPage> createState() => _ClockPageState(); // 対になる_ClockPageStateクラスを指定
}

class _ClockPageState extends State<ClockPage> {
  // 実際の状態と画面描画を担当するクラス
  late DateTime _now; // 現在時刻を取得して保持する
  late Timer _timer; // 1秒ごとに時刻を更新する
  @override
  void initState() {
    // Widgetが画面に表示される瞬間に1回だけ実行される
    super.initState();
    _now = DateTime.now(); // 現在時刻を取得する
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 1秒ごとに処理を繰り返す
      setState(() {
        // 画面を再描画する
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  } // Widgetが画面から消えた時にタイマーをキャンセルすることで、メモリ消費を抑える

  @override
  Widget build(BuildContext context) {
    // ページの見た目を変更する
    String hour = _now.hour.toString();
    String minute = _now.minute.toString().padLeft(2, '0');
    String second = _now.second.toString().padLeft(2, '0');
    String year = _now.year.toString();
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
              style: TextStyle(color: Colors.white, fontSize: 120),
            ),
            Text(
              "$year/$month/$day",
              style: TextStyle(color: Colors.white, fontSize: 80),
            ),
          ],
        ),
      ),
    );
  }
}
