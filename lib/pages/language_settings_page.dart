import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          appState.language == 'ja' ? '言語' : 'Language',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('日本語', style: TextStyle(color: Colors.white)),
            trailing: appState.language == 'ja'
                ? const Icon(Icons.check, color: Colors.white)
                : null,
            onTap: () {
              appState.setLanguage('ja');
            },
          ),
          ListTile(
            title: const Text('English', style: TextStyle(color: Colors.white)),
            trailing: appState.language == 'en'
                ? const Icon(Icons.check, color: Colors.white)
                : null,
            onTap: () {
              appState.setLanguage('en');
            },
          ),
        ],
      ),
    );
  }
}
