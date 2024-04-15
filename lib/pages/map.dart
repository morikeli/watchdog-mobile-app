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
    final response = await http.get(Uri.parse('$api/api/incident/accidents'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> geoLocation = data['results'];

      for (var markerCoord in geoLocation) {
        double latitude = markerCoord['location']['latitude'];
        double longitude = markerCoord['location']['longitude'];

        setState(() {
          coordinates.add(
            Marker(
              point: LatLng(latitude, longitude),
              child: const Icon(
                Icons.location_on_sharp, 
                color: Colors.red,
              )
            )
          );
        });
      }
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
        mapController: _mapController,
          options: const MapOptions(
            initialCenter: LatLng(0.0236, 37.9062),
            initialZoom: 8,
            minZoom: 7,
            maxZoom: 14,
            interactionOptions: InteractionOptions(
              enableScrollWheel: false,
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate
            )
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleatflet.flutter_map.example',
            ),
            MarkerLayer(
              rotate: false,
              markers: coordinates,
            ),
            
            
          ],
      ),
    );
  }
}