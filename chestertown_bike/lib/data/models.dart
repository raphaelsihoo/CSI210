// lib/data/models.dart
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Represents one saved bike route.
class SavedRoute {
  final String id; // unique id for this route
  final String title; // user's title (ex: "River Loop")
  final String note; // optional memo/notes
  final List<LatLng> points; // ordered points the user tapped
  final DateTime createdAt; // when it was created

  SavedRoute({
    required this.id,
    required this.title,
    required this.note,
    required this.points,
    required this.createdAt,
  });

  // Convert SavedRoute to a Map for serialization. (to save)
  Map<String, dynamic> toJson() => { // toJson(): A method that converts the SavedRoute object into a Map<String, dynamic> format for serialization and storage.
    'id': id,
    'title': title,
    'note': note,
    'createdAt': createdAt.toIso8601String(),
    'points': points
        .map((p) => {'lat': p.latitude, 'lng': p.longitude})
        .toList(),
  };

  // Recreate object from saved Map. (to load)
  factory SavedRoute.fromJson(Map<String, dynamic> json) { // fromJson(): A factory constructor that creates a SavedRoute object from a Map<String, dynamic> format, typically used for deserialization when loading saved data.
    final pts = (json['points'] as List)
        .map(
          (m) => LatLng(
            (m['lat'] as num).toDouble(),
            (m['lng'] as num).toDouble(),
          ),
        )
        .toList();

    return SavedRoute(
      id: json['id'],
      title: json['title'],
      note: json['note'] ?? '',
      points: pts,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
