import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Chestertown Bike')),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Home (Map)'),
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false),
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Text('Saved Routes'),
              onTap: () => Navigator.pushNamed(context, '/saved'),
            ),
          ],
        ),
      ),
    );
  }
}