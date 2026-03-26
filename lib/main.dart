import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'app_state.dart';
import 'pages/clock_page.dart';
import 'pages/settings_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: appState.isLocalFont ? appState.fontFamily : null,
              textTheme: appState.isLocalFont
                  ? null
                  : GoogleFonts.getTextTheme(appState.fontFamily),
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isClockPage = _currentIndex == 0;
    final showBottomNav = !isLandscape || !isClockPage;

    return Scaffold(
      body: _currentIndex == 0
          ? ClockPage(
              onSettingsTap: () {
                if (isLandscape) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  );
                } else {
                  setState(() => _currentIndex = 1);
                }
              },
            )
          : const SettingsPage(),
      bottomNavigationBar: showBottomNav
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.access_time),
                  label: appState.language == 'ja' ? '時計' : 'Clock',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: appState.language == 'ja' ? '設定' : 'Settings',
                ),
              ],
            )
          : null,
    );
  }
}