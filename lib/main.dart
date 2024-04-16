import 'package:flutter/material.dart';
import 'package:watchdog/constants/colors.dart';
import 'package:watchdog/pages/login.dart';
import 'package:watchdog/pages/map.dart';
import 'package:watchdog/pages/profile.dart';
import 'package:watchdog/pages/suspects.dart';
import 'package:watchdog/screens/onboarding/onboarding.dart';
import 'package:watchdog/screens/splash_screen.dart';
import 'pages/homepage.dart';


void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: kAppBarColor,
          iconTheme: IconThemeData(
            color: Color(0xFFFFFFFF),
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white
        ),
        primaryColor: kPrimaryColor,
      ),
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
