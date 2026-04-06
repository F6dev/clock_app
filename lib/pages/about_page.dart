import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_state.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _tapCount = 0;
  DateTime? _lastTapTime;

  void _onBuildNumberTap(BuildContext context, AppState appState) {
    final now = DateTime.now();
    if (_lastTapTime != null && now.difference(_lastTapTime!).inSeconds > 2) {
      _tapCount = 0;
    }
    _lastTapTime = now;
    _tapCount++;
    if (_tapCount >= 5) {
      _tapCount = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _SudoPage(appState: appState)),
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

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
          appState.language == 'ja' ? 'このアプリについて' : 'About',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    'assets/launcher_icon/android_icon.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'clock_app',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                const SizedBox(height: 4),
                const Text(
                  'v1.2',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.grey),
          ListTile(
            title: Text(
              appState.language == 'ja'
                  ? 'ソースコード (GitHub)'
                  : 'Source Code (GitHub)',
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.open_in_new, color: Colors.grey),
            onTap: () => _launchUrl('https://github.com/F6dev/clock_app'),
          ),
          ListTile(
            title: const Text(
              'Twitter / X (@1unarw)',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.open_in_new, color: Colors.grey),
            onTap: () => _launchUrl('https://twitter.com/1unarw'),
          ),
          ListTile(
            title: const Text(
              'Discord (@lunarw)',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.open_in_new, color: Colors.grey),
            onTap: () =>
                _launchUrl('https://discord.com/users/1272765804731039755'),
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.grey),
          ListTile(
            title: Text(
              appState.language == 'ja' ? 'バグ報告' : 'Report a Bug',
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.bug_report, color: Colors.grey),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey[900],
                  title: Text(
                    appState.language == 'ja' ? 'バグ報告' : 'Report a Bug',
                    style: const TextStyle(color: Colors.white),
                  ),
                  content: Text(
                    appState.language == 'ja'
                        ? 'バグを発見した場合は以下の方法でご報告ください。\n\n・GitHub Issues\n・Twitter / X (@1unarw)\n・Discord'
                        : 'If you find a bug, please report it via:\n\n・GitHub Issues\n・Twitter / X (@1unarw)\n・Discord',
                    style: const TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        appState.language == 'ja' ? '閉じる' : 'Close',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              appState.language == 'ja' ? 'ヘルプ' : 'Help',
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.open_in_new, color: Colors.grey),
            onTap: () =>
                _launchUrl('https://github.com/F6dev/clock_app#readme-ov-file'),
          ),
          ListTile(
            /* title: const Text('Build', style: TextStyle(color: Colors.grey)), */
            title: Text(
              appState.language == 'ja' ? 'ビルド番号' : 'Build Number',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'v1.2-260406',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () => _onBuildNumberTap(context, appState),
          ),
          const Divider(color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              appState.language == 'ja' ? 'ライセンス' : 'License',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              'MIT License\nCopyright (c) 2026 @Lunar',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          ListTile(
            title: Text(
              appState.language == 'ja' ? 'ライセンス全文' : 'Full License',
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.open_in_new, color: Colors.grey),
            onTap: () => _launchUrl(
              'https://github.com/F6dev/clock_app/blob/dev/LICENSE.txt',
            ),
          ),
        ],
      ),
    );
  }
}

class _SudoPage extends StatelessWidget {
  final AppState appState;
  const _SudoPage({required this.appState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appState.language == 'ja'
                  ? 'あなたはシステム管理者から通常の講習を受けたはずです。\nこれは通常、以下の3点に要約されます:\n\n    #1) 他人のプライバシーを尊重すること。\n    #2) タイプする前に考えること。\n    #3) 大いなる力には大いなる責任が伴うこと。'
                  : 'We trust you have received the usual lecture from the local System Administrator. It usually boils down to these three things:\n\n    #1) Respect the privacy of others.\n    #2) Think before you type.\n    #3) With great power comes great responsibility.',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                height: 2,
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text('OK'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse('https://www.sudo.ws/');
                  if (!await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw 'Could not launch $url';
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  appState.language == 'ja'
                      ? 'さらに詳しく...'
                      : 'More information...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
