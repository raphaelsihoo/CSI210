// lib/data/repository.dart
import 'models.dart';

class RouteRepository {
  RouteRepository._();
  static final RouteRepository i = RouteRepository._();

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
