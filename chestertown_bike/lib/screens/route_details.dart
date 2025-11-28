import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/models.dart';

// RouteDetailsScreen: A screen that allows users to input details for a bike route, including title and notes, and returns a SavedRoute object upon submission.
class RouteDetailsScreen extends StatefulWidget {
  final List<LatLng> points;
  const RouteDetailsScreen({
    super.key,
    required this.points,
  }); // users pass the LatLng points they tapped on the map to the RouteDetailsScreen

  @override
  State<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  // actual brain for RouteDetailsScreen
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String _routeType = ''; // default

  @override
  void dispose() {
    _titleCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  // This is called when user taps 'Save' button
  void _submit() {
    // sumit() calles SavedRoute and returns to caller
    if (_formKey.currentState!.validate()) {
      final route = SavedRoute(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleCtrl.text.trim(),
        note: _noteCtrl.text.trim(),
        points: List<LatLng>.from(widget.points),
        createdAt: DateTime.now(),
        routeType: _routeType,
      );
      Navigator.pop(
        context,
        route,
      ); // return to caller with the route (going back to MapScreen with the new route data)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          // Form: A widget that groups multiple form fields and manages their validation and submission.
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller:
                    _titleCtrl, // _titleCtrl: Controller for the title input field.
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Enter a title'
                    : null, // validator: A function that checks if the title input is valid, returning an error message if it's empty.
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller:
                    _noteCtrl, // _noteCtrl: Controller for the notes input field.
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                ),
                maxLines: 3, // allow multiple lines for notes
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 20),
              Text(
                "Select Route Type:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              RadioListTile(
                title: const Text("Road"),
                value: "Road",
                groupValue: _routeType,
                onChanged: (value) {
                  setState(() {
                    _routeType = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Gravel"),
                value: "Gravel",
                groupValue: _routeType,
                onChanged: (value) {
                  setState(() {
                    _routeType = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Scenic"),
                value: "Scenic",
                groupValue: _routeType,
                onChanged: (value) {
                  setState(() {
                    _routeType = value!;
                  });
                },
              ),

              ElevatedButton(
                onPressed: _submit,
                child: const Text('Save'),
              ), // When user taps 'Save', _submit() is called to validate and return the route.
            ],
          ),
        ),
      ),
    );
  }
}
