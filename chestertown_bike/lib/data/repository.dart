// lib/data/repository.dart
import 'models.dart';

// this is for managing saved routes in memory
// RouteRepository: A singleton class that manages the collection of saved bike routes in memory.
// this is needed so multiple screens can access the same list of routes.
class RouteRepository {
  RouteRepository._();
  static final RouteRepository i = RouteRepository._(); // _(): Private constructor to enforce singleton pattern. singleton pattern: A design pattern that restricts the instantiation of a class to a single

  final List<SavedRoute> _routes = <SavedRoute>[];

  List<SavedRoute> get all => List.unmodifiable(_routes);

  void add(SavedRoute route) => _routes.add(route);

  void removeById(String id) {
    _routes.removeWhere((r) => r.id == id);
  }

  SavedRoute? getById(String id) {
    try {
      return _routes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }
}
