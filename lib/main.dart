import 'package:flutter/material.dart';
import 'package:watchdog/pages/login.dart';
import 'package:watchdog/pages/map.dart';
import 'package:watchdog/pages/profile.dart';
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
        '/login': (context) => const LoginPage(),
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const Homepage(),
        '/map': (context) => const OSMMap(),
        '/suspects': (context) => const WantedSuspects(),
        '/profile': (context) => const ProfileScreen(),
      },
      initialRoute: '/splash',
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
