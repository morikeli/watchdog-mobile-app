import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCoordinates();
  }

  Future<void> fetchCoordinates() async {
    setState(() {
      isLoading = true;  
    });
    await Future.delayed(const Duration(seconds: 1));

    try {
      http.Response response = await http.get(Uri.parse('$api/incidents/location'));
      if (response.statusCode == 200) {
        isLoading = false;
        List<dynamic> data = json.decode(response.body);

        setState(() {
          isLoading = false;
        });
        
        for (var markerCoord in data) {
          double latitude = markerCoord['latitude'];
          double longitude = markerCoord['longitude'];

          coordinates.add(
            Marker(
              point: LatLng(latitude, longitude),
              child: const Icon(
                Icons.location_on_sharp, 
                color: Colors.red,
              )
            )
          );
        }
      } else {
        isLoading = false;
        Fluttertoast.showToast(
          msg: 'Please check your internet connection!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

    } catch(e) {
        Fluttertoast.showToast(
          msg: 'It seems you may have internet connection issues!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        throw Exception('Exception is $e');
    }
    
  }

  Future<void> _refreshData() async {
    await fetchCoordinates();
  }

  void zoomIn() {
    _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 1);
  }

  void zoomOut() {
    _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 1);
  }
  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.popAndPushNamed(context, '/home'),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: _refreshData, 
              icon: const Icon(Icons.refresh_outlined)
            ),
          ],
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
      ),
      Positioned(
          bottom: 10,
          right: 10,
          child: Column(
            children: [
              FloatingActionButton(
                mini: true,
                onPressed: zoomIn,
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                mini: true,
                onPressed: zoomOut,
                child: const Icon(Icons.remove),
              )
            ],
          ),
        ),
      ]
    );
  }
}