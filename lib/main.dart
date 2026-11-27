import 'package:flutter/material.dart';
import 'package:the_catholic_faith/pages/navbar.dart';
import 'package:the_catholic_faith/pages/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

String theme = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  theme = prefs.getString('theme') ?? 'System';

  final bool onboardingComplete = prefs.getBool('onboarding_complete') ?? false;
  runApp(onboardingComplete ? const Main() : const Onboarding());
}

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
    Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => CupertinoOnboardingScreen(
          onComplete: () {
            SharedPreferences.getInstance().then((prefs) {
              prefs.setBool('onboarding_complete', true);
            });
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (_) => const Main()),
            );
          },
        ),
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
    Widget build(BuildContext context) {
    const seedColor = Colors.white;
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: switch (theme) {
        'Light' => ThemeMode.light,
        'Dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      },
      debugShowCheckedModeBanner: false,
      home: Bar()
    );
  }
}