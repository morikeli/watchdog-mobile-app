import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:watchdog/constants/api.dart';
import 'dart:convert';

class OSMMap extends StatefulWidget {
  const OSMMap({super.key});

  @override
  State<OSMMap> createState() => _OSMMapState();
}


class _OSMMapState extends State<OSMMap> {
  final MapController _mapController = MapController();
  List<Marker> coordinates = [];

  @override
  void initState() {
    super.initState();
    fetchCoordinates();
  }

  Future<void> fetchCoordinates() async {
    final response = await http.get(Uri.parse('$api/incident/accidents'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        coordinates = List<LatLng>.from(data.map((item) => LatLng(item['location']['latitude'], item['location']['longitude'])));      
        print('Coordinates: $coordinates');
      });
    } else {
      throw Exception('Failed to load coordinates');
    }
  }

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
      
      body: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(0.0236, 37.9062),
            initialZoom: 8,
            minZoom: 7,
            maxZoom: 14,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleatflet.flutter_map.example',
            ),
            MarkerLayer(
              rotate: false,
              markers: coordinates.expand((LatLng point) => {
                Marker(
                  rotate: false,
                  point: point,
                  child: const Icon(Icons.location_on_outlined, color: Colors.red),
                )
              }).toList()
            ),
          ],
      ),
    );
  }
}