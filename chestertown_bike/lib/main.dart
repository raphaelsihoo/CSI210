import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'data/models.dart';
import 'screens/route_details.dart';
import 'data/repository.dart';

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

class SavedRoutesScreen extends StatelessWidget {
  const SavedRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = RouteRepository.i.all; // read from repository

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Routes')),
      body: routes.isEmpty
          ? const Center(child: Text('No saved routes yet'))
          : ListView.separated(
              // ListView.separated: A scrollable list of widgets separated by divider widgets, useful for displaying lists with visual separation between items.
              itemCount: routes.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final r = routes[index];
                return ListTile(
                  title: Text(r.title),
                  subtitle: Text(
                    '${r.points.length} points • ${r.createdAt.toLocal().toString().split(".").first}',
                  ),
                );
              },
            ),
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
      <
        Marker
      >{}; // this stores all markers you add by tapping the map. {} means a Set literal
  final List<LatLng> _points =
      <
        LatLng
      >[]; // this is to keep an ordered path (added in addition to Set<Marker>)
  Set<Polyline> _polylines = <Polyline>{};

  void _refreshPolyline() {
    _polylines = {
      Polyline(
        polylineId: const PolylineId('route'),
        width: 4,
        color: Colors.indigo,
        points: List<LatLng>.from(
          _points,
        ), // ordered list of points from _points
      ),
    };
  }

  int _nextMarkerId = 0;

  void _saveCurrentRouteDraft() async {
    if (_points.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add at least two points to form a route.'),
        ),
      );
      return;
    }

    // Navigate to the details form, pass the current points
    // this will return a SavedRoute object when done
    final route = await Navigator.push<SavedRoute>(
      // await: Waits for the result of the navigation operation, which will be a SavedRoute object when the user completes the form.
      context,
      MaterialPageRoute(
        // MaterialPageRoute: A widget that creates a route that transitions to a new screen using a platform-specific animation.
        builder: (_) => RouteDetailsScreen(points: List<LatLng>.from(_points)),
      ),
    );

    if (route != null) {
      // if the user submitted the form (did not cancel) form: The user interface that collects input from the user, in this case, the route details.
      // 1) store it
      RouteRepository.i.add(route);

      // 2) feedback
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Saved "${route.title}"')));

      // 3) clear drawing
      setState(() {
        _markers.clear();
        _points.clear();
        _polylines.clear();
      });

      // 4) go to Saved Routes screen
      Navigator.pushNamed(context, '/saved');

      // NEXT: you’ll store `route` somewhere (in-memory list or shared_preferences),
      // and show it on the Saved Routes screen.
    }
  }

  // _undoLastPoint: Removes the last point added to the route and updates the map accordingly.
  void _undoLastPoint() {
    if (_points.isEmpty) return;
    setState(() {
      _points.removeLast();
      // also remove last marker (we gave markers ids 0,1,2,… in order)
      if (_nextMarkerId > 0) {
        _nextMarkerId--;
        final idToRemove = MarkerId('$_nextMarkerId');
        _markers.removeWhere((m) => m.markerId == idToRemove);
      }
      _refreshPolyline();
    });
  }

  @override // Overrides the dispose method to clean up resources when the widget is removed from the widget tree.
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

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
                  // pushNamedAndRemoveUntil: Navigates to the specified route and removes all previous routes until the specified condition is met.
                  context,
                  '/',
                  (r) => false,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.save),
                title: const Text('Saved Routes'),
                onTap: () => Navigator.pushNamed(
                  context,
                  '/saved',
                ), // pushNamed: Navigates to the specified route without removing any previous routes.
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
                _points.add(latLng); // ordered list (for saving)
                final id = MarkerId(
                  '${_nextMarkerId++}',
                ); // this is needed to give each marker a unique id
                _markers.add(Marker(markerId: id, position: latLng));
                _refreshPolyline();
              });
            },
            markers: _markers,
            polylines: _polylines,
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: 'clear',
                  onPressed: () => setState(() {
                    _markers.clear();
                    _points.clear();
                    _polylines.clear();
                  }),
                  child: const Icon(Icons.clear),
                ),

                const SizedBox(height: 12),
                FloatingActionButton.small(
                  heroTag: 'undo',
                  onPressed: _undoLastPoint,
                  child: const Icon(Icons.undo),
                ),

                const SizedBox(height: 12),
                FloatingActionButton.small(
                  heroTag: 'save',
                  onPressed: _saveCurrentRouteDraft,
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
