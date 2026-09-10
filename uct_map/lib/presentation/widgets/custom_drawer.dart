import 'package:flutter/material.dart';
import 'uct_logo.dart';

class CustomDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSelectTab;

  const CustomDrawer({
    super.key,
    required this.currentIndex,
    required this.onSelectTab,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'UCT Map',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: const Text('Universidad Católica de Temuco'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: UctLogo(height: 48, width: 48),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: const Text('Mapa del Campus'),
            selected: currentIndex == 0,
            onTap: () {
              Navigator.pop(context);
              onSelectTab(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Búsqueda de Espacios'),
            selected: currentIndex == 1,
            onTap: () {
              Navigator.pop(context);
              onSelectTab(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Objetos Perdidos'),
            selected: currentIndex == 2,
            onTap: () {
              Navigator.pop(context);
              onSelectTab(2);
            },
          ),
          ListTile(
            leading: const Icon(Icons.report_problem_outlined),
            title: const Text('Reportes de Incidencias'),
            selected: currentIndex == 3,
            onTap: () {
              Navigator.pop(context);
              onSelectTab(3);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Mi Perfil'),
            selected: currentIndex == 4,
            onTap: () {
              Navigator.pop(context);
              onSelectTab(4);
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Otros Servicios',
              style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Directorio de Profesores'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/professors');
            },
          ),
        ],
      ),
    );
  }
}
