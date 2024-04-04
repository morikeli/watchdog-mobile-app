import 'package:flutter/material.dart';
import 'package:watchdog/pages/map.dart';
import 'package:watchdog/pages/suspects.dart';
import 'package:watchdog/screens/onboarding/onboarding.dart';
import 'package:watchdog/screens/onboarding/splash_screen.dart';
import 'pages/homepage.dart';


void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '': (context) => const OnboardingScreen(),
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const Homepage(),
        '/map': (context) => const OSMMap(),
        '/suspects': (context) => const WantedSuspects(),
      },
      initialRoute: '/splash',
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
