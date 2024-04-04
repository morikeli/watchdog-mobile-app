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
        leading: IconButton(
          onPressed: () => Navigator.popAndPushNamed(context, '/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Wanted suspects',
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