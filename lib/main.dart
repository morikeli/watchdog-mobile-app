import 'package:flutter/material.dart';
import 'package:watchdog/constants/colors.dart';
import 'package:watchdog/screens/login.dart';
import 'package:watchdog/screens/map.dart';
import 'package:watchdog/screens/profile.dart';
import 'package:watchdog/screens/suspects.dart';
import 'package:watchdog/screens/onboarding/onboarding.dart';
import 'package:watchdog/screens/splash_screen.dart';
import 'screens/homepage.dart';


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
            color: kIconColor,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: kAppBarColor,
          selectedIconTheme: IconThemeData(
            color: kIconColor,
          ),
          selectedItemColor: kTextColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: kTextColor
        ),
        datePickerTheme: DatePickerThemeData(
          confirmButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          ),
          todayBackgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          todayForegroundColor: MaterialStateProperty.all<Color>(kTextColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              kPrimaryColor
            ),
            foregroundColor:  MaterialStateProperty.all<Color>(
              kTextColor
            )
          )
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kPrimaryColor,
          foregroundColor: kIconColor,
          shape: CircleBorder()
        ),
        primaryColor: kPrimaryColor,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: kPrimaryColor,
        ),
        timePickerTheme: TimePickerThemeData(
          confirmButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          ),
          dialHandColor: kPrimaryColor,
        )
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
