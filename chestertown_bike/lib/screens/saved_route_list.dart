import 'package:flutter/material.dart';
import '../data/repository.dart';
import '../screens/route_view.dart';
import '../widgets/app_drawer.dart';

// SavedRoutesScreen: A screen that displays a list of saved bike routes, allowing users to view details of each route by tapping on them.
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
              itemCount: routes.length, // routes = a list of SavedRoute
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final r = routes[index];
                return ListTile(
                  title: Text(r.title),
                  subtitle: Text(
                    '${r.points.length} points • ${r.createdAt.toLocal().toString().split(".").first}',
                  ),
                  onTap: () {
                    // onTap: A callback function that is triggered when the list tile is tapped, navigating to the RouteViewScreen to display the selected route.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RouteViewScreen(route: r),
                      ),
                    );
                  },
                );
              },
            ),
      drawer: const AppDrawer(),
    );
  }
}
