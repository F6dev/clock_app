import 'package:flutter/material.dart';
import 'font_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('設定', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          _sectionHeader('一般設定'),
          _settingsTile(context, '言語', '日本語', null),
          _settingsTile(context, 'フォント設定', '', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FontSettingsPage()),
            );
          }),
          _settingsTile(context, 'Coffee', '', null),
          _sectionHeader('時計設定'),
          _settingsTile(context, '端末の時刻・日付の編集', '', null),
          _settingsTile(context, 'アプリの時間調整', '', null),
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
