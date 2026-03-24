import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_state.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                  borderRadius: BorderRadius.circular(16),
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
                  'v1.0',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.grey),
          ListTile(
            title: Text(
              appState.language == 'ja' ? 'ソースコード (GitHub)' : 'Source Code (GitHub)',
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.open_in_new, color: Colors.grey),
            onTap: () => _launchUrl('https://github.com/F6dev/clock_app'),
          ),
          ListTile(
            title: const Text(
              'Twitter / X',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.open_in_new, color: Colors.grey),
            onTap: () => _launchUrl('https://twitter.com/1unarw'),
          ),
          ListTile(
            title: const Text('Discord', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.open_in_new, color: Colors.grey),
            onTap: () =>
                _launchUrl('https://discord.com/users/1272765804731039755'),
          ),
          ListTile(
            title: const Text(
              'Instagram',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.open_in_new, color: Colors.grey),
            onTap: () => _launchUrl('https://instagram.com/1unarw'),
          ),
        ],
      ),
    );
  }
}
