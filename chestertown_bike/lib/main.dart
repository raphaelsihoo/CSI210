import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Chestertown Bike Map', home: MapScreen());
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller; // Controller: Manages the Google Map instance, which means it handles user interactions and map updates.

  static const LatLng _chestertown = LatLng(39.2090, -76.0660); // LatLng: Represents a geographical point with latitude and longitude coordinates.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chestertown Bike Routes'),
        backgroundColor: Colors.indigo,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _chestertown,
          zoom: 14,
        ),
        onMapCreated: (controller) {
          _controller = controller;
        },
      ),
    );
  }
}
