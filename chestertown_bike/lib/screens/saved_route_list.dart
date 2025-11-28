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
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: routes.length, // number of tiles
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // grid layout
                crossAxisCount: 2, // 2 cards per row
                crossAxisSpacing: 12, // spacing between columns
                mainAxisSpacing: 12, // spacing between rows
                childAspectRatio: 1.2, // shape of the tiles (1.2 = width is 1.2x height)
              ),
              itemBuilder: (context, index) {
                final r = routes[index];

                return GestureDetector( // make the tile tappable
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RouteViewScreen(route: r),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration( // tile style
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow( // shadow effect for tile
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3), // shadow position (x,y)
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),

                    // Tile content
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (r.imageBytes != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              r.imageBytes!,
                              height: 80,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          Icon(Icons.map, size: 40, color: Colors.indigo),
                          
                        const SizedBox(height: 10),
                        Text(
                          r.title,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${r.points.length} points",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      drawer: const AppDrawer(),
    );
  }
}
