import 'package:flutter/material.dart';
import 'font_settings_page.dart';
import 'language_settings_page.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'time_adjustment_page.dart';
import 'about_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          appState.language == 'ja' ? '設定' : 'Settings',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          _sectionHeader(appState.language == 'ja' ? '一般設定' : 'General'),
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
              appState.coffee
                  ? (appState.language == 'ja'
                        ? '有効: アプリを開いている間はスリープしない'
                        : 'Enabled: Keep awake while the app is open')
                  : (appState.language == 'ja'
                        ? '無効: 自動的にスリープする'
                        : 'Disabled: Auto sleep'),
              style: const TextStyle(color: Colors.grey),
            ),
            value: appState.coffee,
            onChanged: (value) {
              appState.setCoffee(value);
            },
            activeThumbColor: Colors.white,
          ),
          _sectionHeader(appState.language == 'ja' ? '時計設定' : 'Clock Settings'),
          _settingsTile(
            context,
            appState.language == 'ja' ? 'アプリの時間の調整' : 'Time Adjustment',
            '',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TimeAdjustmentPage()),
              );
            },
          ),
          _sectionHeader(appState.language == 'ja' ? 'アプリ情報' : 'App Info'),
          _settingsTile(
            context,
            appState.language == 'ja' ? 'このアプリについて' : 'About',
            '',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              );
            },
          ),
          _sectionHeader(appState.language == 'ja' ? 'リセット' : 'Reset'),
          ListTile(
            title: Text(
              appState.language == 'ja' ? '初期設定に戻す' : 'Reset to Default',
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey[900],
                  title: Text(
                    appState.language == 'ja' ? '初期設定に戻す' : 'Reset to Default',
                    style: const TextStyle(color: Colors.white),
                  ),
                  content: Text(
                    appState.language == 'ja'
                        ? '全ての設定を初期化しますか？'
                        : 'Reset all settings to default?',
                    style: const TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        appState.language == 'ja' ? 'キャンセル' : 'Cancel',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        appState.resetPreferences();
                        Navigator.pop(context);
                      },
                      child: Text(
                        appState.language == 'ja' ? 'リセット' : 'Reset',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
