import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/models.dart';
import '../widgets/app_drawer.dart';

// RouteViewScreen: A screen that displays a saved bike route on a Google Map, showing markers for each point and a polyline connecting them.
class RouteViewScreen extends StatefulWidget {
  final SavedRoute route;
  const RouteViewScreen({super.key, required this.route});

  @override
  State<RouteViewScreen> createState() => _RouteViewScreenState();
}

class _RouteViewScreenState extends State<RouteViewScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = <Marker>{};
  Set<Polyline> _polylines = <Polyline>{};

  @override
  void initState() {
    super.initState();
    // 1 marker per point (for visibility)
    _markers = {
      for (var i = 0; i < widget.route.points.length; i++)
        Marker(markerId: MarkerId('m$i'), position: widget.route.points[i]),
    };
    // one polyline that connects all points in order
    _polylines = {
      Polyline(
        polylineId: const PolylineId('saved_route'),
        width: 4,
        color: Colors.indigo,
        points: widget.route.points,
      ),
    };
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  CameraPosition _initialCamera() {
    final pts = widget.route.points;
    if (pts.isNotEmpty) {
      return CameraPosition(target: pts.first, zoom: 14);
    }
    // fallback (Chestertown downtown-ish)
    return const CameraPosition(target: LatLng(39.2090, -76.0660), zoom: 14);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.route.title)),
      body: Row(
        children: [
          Expanded(
            flex: 3, // Map takes about 75%
            child: GoogleMap(
              initialCameraPosition: _initialCamera(),
              onMapCreated: (c) => _controller = c,
              markers: _markers,
              polylines: _polylines,
            ),
          ),
          if (widget.route.imageBytes != null)
            Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromARGB(210, 121, 6, 6), // background color
                child: Center(
                  child: Container(
                    width: 270,
                    height: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color.fromARGB(66, 81, 118, 238)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.memory(
                      widget.route.imageBytes!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}
