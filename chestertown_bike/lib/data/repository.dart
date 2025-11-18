// lib/data/repository.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

// this is for managing saved routes in memory
// RouteRepository: A singleton class that manages the collection of saved bike routes in memory.
// this is needed so multiple screens can access the same list of routes.
class RouteRepository {
  RouteRepository._(); // private constructor
  static final RouteRepository i =
      RouteRepository._(); // _(): Private constructor to enforce singleton pattern. singleton pattern: A design pattern that restricts the instantiation of a class to a single

  final List<SavedRoute> _routes = <SavedRoute>[]; // create in-memory list of saved routes

  // get all saved routes
  List<SavedRoute> get all => List.unmodifiable(_routes); // all: A getter that returns an unmodifiable view of the list of saved bike routes, preventing external modification of the internal list.

  // Load saved data(routes) from local storage
  // Future<void> means that this will take time to complete (async) and does not return any value when done.
  Future<void> loadAll() async {
    // loadAll(): A method that retrieves the saved list of bike routes from local storage, deserializes them, and populates the in-memory list of routes.
    final prefs =
        await SharedPreferences.getInstance(); // SharedPreferences: A Flutter plugin that provides a persistent storage solution for simple data types using key-value pairs. 
    final raw = prefs.getString('routes');
    if (raw == null) return; // nothing saved yet

    final list = jsonDecode(raw) as List; // jsonDecode(): A function that decodes a JSON-encoded string into a Dart object, typically used for deserializing data retrieved from storage.
    _routes
      ..clear() // clear existing list. The reason why we clear first is to avoid duplicates when loading multiple times.
      ..addAll(list.map((r) => SavedRoute.fromJson(r as Map<String, dynamic>)));
  }

  // Save current list/data(routes) to local storage
  Future<void> saveAll() async {
    // saveAll(): A method that serializes the current list of bike routes and saves them to local storage for persistent storage.
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _routes.map((r) => r.toJson()).toList(); // r.toJson() from models.dart
    await prefs.setString('routes', jsonEncode(jsonList)); // pair key 'routes' with the serialized JSON string of routes, which is jsonEncode(jsonList). *jsonList is converted to JSON string using jsonEncode().
  }

  Future<void> add(SavedRoute route) async {
    // add(): A method that adds a new bike route to the in-memory list and persists the updated list to local storage.
    _routes.add(route);
    await saveAll();
  }
}
