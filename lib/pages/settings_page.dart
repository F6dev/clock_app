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
          _sectionHeader(appState.language == 'ja' ? '一般設定' : 'General'),
            _settingsTile(context, appState.language == 'ja' ? '言語' : 'Language', appState.language == 'ja' ? '日本語' : 'English', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LanguageSettingsPage()),
            );
          }),
          _settingsTile(context, appState.language == 'ja' ? 'フォント設定' : 'Font Settings', '', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FontSettingsPage()),
            );
          }),
          _settingsTile(context, appState.language == 'ja' ? 'Coffee' : 'Coffee', '', null),
          _sectionHeader(appState.language == 'ja' ? '時計設定' : 'Clock Settings'),
          _settingsTile(context, appState.language == 'ja' ? 'システム時刻を編集' : 'Edit System Time', '', null),
          _settingsTile(context, appState.language == 'ja' ? 'アプリの時間の調整' : 'Edit App Time', '', null),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
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
