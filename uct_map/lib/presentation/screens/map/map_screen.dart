import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Visor interactivo del mapa (Canvas / WebView / MapLibre / OpenStreetMap)
        Container(
          color: Colors.blueGrey.shade50,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 80,
                  color: Colors.blueGrey.shade300,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Mapa Interactivo - Campus UCT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Visualización de edificios, salas, pisos y rutas peatonales.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Barra flotante superior: Selector de Campus
        Positioned(
          top: 12,
          left: 16,
          right: 16,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.location_city, color: Color(0xFF003865)),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Campus San Juan Pablo II',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    tooltip: 'Cambiar Campus',
                    onPressed: () {
                      _showCampusSelector(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // Botones flotantes de acción en el mapa (GPS, Capas)
        Positioned(
          right: 16,
          bottom: 24,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.small(
                heroTag: 'map_layers',
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF003865),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Selección de capas de mapa')),
                  );
                },
                tooltip: 'Capas',
                child: const Icon(Icons.layers_outlined),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: 'map_gps',
                backgroundColor: const Color(0xFF003865),
                foregroundColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Centrando en tu ubicación actual...')),
                  );
                },
                tooltip: 'Mi ubicación',
                child: const Icon(Icons.my_location),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCampusSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selecciona un Campus',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.location_on, color: Color(0xFF003865)),
                title: const Text('Campus San Juan Pablo II'),
                subtitle: const Text('Ruta 5 Sur Km 670, Temuco'),
                trailing: const Icon(Icons.check, color: Colors.green),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Campus San Francisco'),
                subtitle: const Text('Manuel Montt 56, Temuco'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Campus Dr. Luis Rivas del Canto'),
                subtitle: const Text('Av. Prieto Norte 371, Temuco'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
