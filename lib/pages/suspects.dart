import 'package:flutter/material.dart';


class WantedSuspects extends StatefulWidget {
  const WantedSuspects({super.key});

  @override
  State<WantedSuspects> createState() => _WantedSuspectsState();
}

class _WantedSuspectsState extends State<WantedSuspects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'),
        title: const Text(
          'Watchdog',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}