import 'package:flutter/material.dart';
import 'package:the_catholic_faith/pages/navbar.dart';
import 'package:the_catholic_faith/pages/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    final bool onboardingComplete = prefs.getBool('onboarding_complete') ?? false;
    if (onboardingComplete) {
      runApp(const Main());
    }
    else {
      runApp(const Onboarding());
    }
  });
}

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
    Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      // In main.dart
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
      // Dark theme
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),
      // Automatically switches based on device settings
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Bar()
    );
  }
}
