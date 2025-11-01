// lib/data/models.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Represents one saved bike route.
class SavedRoute {
  final String id;            // unique id for this route
  final String title;         // user's title (ex: "River Loop")
  final String note;          // optional memo/notes
  final List<LatLng> points;  // ordered points the user tapped
  final DateTime createdAt;   // when it was created

  SavedRoute({
    required this.id,
    required this.title,
    required this.note,
    required this.points,
    required this.createdAt,
  });
}

