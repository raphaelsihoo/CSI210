import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'data/models.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chestertown Bike Map',
      routes: {
        // routes: Defines the available routes in the application, mapping route names to their corresponding widget builders. home: The initial screen displayed when the app starts.
        '/': (_) => const MapScreen(),
        '/saved': (_) =>
            const SavedRoutesScreen(), // placeholder for now. placeholder: A temporary or dummy implementation used for testing or demonstration purposes.
      },
      initialRoute: '/',
    );
  }
}

// The following is a placeholder screen for saved routes.
class SavedRoutesScreen extends StatelessWidget {
  const SavedRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Routes')),
      body: const Center(child: Text('No routes yet')),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

// The following is the main screen displaying the Google Map. _MapScreenState: The state class for MapScreen, managing the state and behavior of the map screen.
class _MapScreenState extends State<MapScreen> {
  GoogleMapController?
  _controller; // Controller: Manages the Google Map instance, which means it handles user interactions and map updates.

  static const LatLng _chestertown = LatLng(
    39.2090,
    -76.0660,
  ); // LatLng: Represents a geographical point with latitude and longitude coordinates.

  Set<Marker> _markers =
      {}; // this stores all markers you add by tapping the map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chestertown Bike Routes'),
        backgroundColor: Colors.indigo,
      ),

      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              const DrawerHeader(child: Text('Chestertown Bike')),
              ListTile(
                leading: const Icon(Icons.map),
                title: const Text('Home (Map)'),
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (r) => false,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.save),
                title: const Text('Saved Routes'),
                onTap: () => Navigator.pushNamed(context, '/saved'),
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        // Stack: A layout widget that allows overlapping of child widgets, useful for layering the map and other UI elements.
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _chestertown,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _controller = controller;
            },
            onTap: (latLng) {
              setState(() {
                final id = MarkerId('${_markers.length + 1}');
                _markers.add(Marker(markerId: id, position: latLng));
              });
            },
            markers: _markers,
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: 'clear',
                  onPressed: () => setState(() => _markers.clear()),
                  child: const Icon(Icons.clear),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.small(
                  heroTag: 'save',
                  onPressed: () {
                    // next step: navigate to details form with current points
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Save coming soon..')),
                    );
                  },
                  child: const Icon(Icons.save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
