import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/login.dart';


void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => const Homepage(),
      },
      initialRoute: '/login',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
