import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class FontSettingsPage extends StatelessWidget {
  const FontSettingsPage({super.key});

  final List<Map<String, dynamic>> fonts = const [
    {'name': 'LINE Seed JP', 'family': 'LINESeedJP', 'isLocal': true},
    {'name': 'Zen Maru Gothic', 'family': 'Zen Maru Gothic', 'isLocal': false},
    {'name': 'Ubuntu', 'family': 'Ubuntu', 'isLocal': false},
    {'name': 'Roboto', 'family': 'Roboto', 'isLocal': false},
    {'name': 'Inter', 'family': 'Inter', 'isLocal': false},
    {'name': 'Lato', 'family': 'Lato', 'isLocal': false},
    {'name': 'Oswald', 'family': 'Oswald', 'isLocal': false},
    {'name': 'Raleway', 'family': 'Raleway', 'isLocal': false},
    {'name': 'Nunito', 'family': 'Nunito', 'isLocal': false},
    {'name': 'Potta One', 'family': 'Potta One', 'isLocal': false},
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          appState.language == 'ja' ? 'フォント' : 'Font',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: fonts.length,
        itemBuilder: (context, index) {
          final font = fonts[index];
          final isSelected = appState.fontFamily == font['family'];
          final textStyle = font['isLocal'] as bool
              ? TextStyle(
                  fontFamily: font['family'] as String,
                  color: Colors.white,
                  fontSize: 18,
                )
              : GoogleFonts.getFont(
                  font['family'] as String,
                  color: Colors.white,
                  fontSize: 18,
                );
          return ListTile(
            title: Text(font['name'] as String, style: textStyle),
            trailing: isSelected
                ? const Icon(Icons.check, color: Colors.white)
                : null,
            onTap: () {
              appState.setFont(
                font['family'] as String,
                font['isLocal'] as bool,
              );
            },
          );
        },
      ),
    );
  }
}
