import 'package:flutter/material.dart';
import 'font_settings_page.dart';
import 'language_settings_page.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          appState.language == 'ja' ? '設定' : 'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          _settingsTile(
            context,
            appState.language == 'ja' ? '言語' : 'Language',
            appState.language == 'ja' ? '日本語' : 'English',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LanguageSettingsPage()),
              );
            },
          ),
          _settingsTile(
            context,
            appState.language == 'ja' ? 'フォント設定' : 'Font Settings',
            '',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FontSettingsPage()),
              );
            },
          ),
          SwitchListTile(
            title: Text(
              appState.language == 'ja' ? 'Coffee' : 'Coffee',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              appState.language == 'ja' ? 'スリープしない' : 'Keep awake',
              style: const TextStyle(color: Colors.grey),
            ),
            value: appState.coffee,
            onChanged: (value) {
              appState.setCoffee(value);
            },
            activeColor: Colors.white,
          ),
          _settingsTile(
            context,
            appState.language == 'ja' ? 'アプリの時間の調整' : 'Time Adjustment',
            '',
            null,
          ),
        ],
      ),
    );
  }

  Widget _settingsTile(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback? onTap,
  ) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: const TextStyle(color: Colors.grey))
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
