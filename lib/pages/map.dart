import 'package:flutter/material.dart';

class OSMMap extends StatefulWidget {
  const OSMMap({super.key});

  @override
  State<OSMMap> createState() => _OSMMapState();
}

class _OSMMapState extends State<OSMMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.popAndPushNamed(context, '/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Map',
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