import 'package:flutter/material.dart';

class ProfessorsScreen extends StatelessWidget {
  const ProfessorsScreen({super.key});

  final List<Map<String, String>> _professors = const [
    {
      'name': 'Dr. Roberto González',
      'department': 'Ingeniería de Software',
      'office': 'Oficina 304 - Edificio Central',
      'email': 'rgonzalez@uct.cl',
    },
    {
      'name': 'Dra. Marcela Soto',
      'department': 'Ciencias de la Computación',
      'office': 'Oficina 210 - Edificio C',
      'email': 'msoto@uct.cl',
    },
    {
      'name': 'Mg. Carlos Peña',
      'department': 'Redes y Telecomunicaciones',
      'office': 'Oficina 105 - Laboratorios',
      'email': 'cpena@uct.cl',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Profesores'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar profesor por nombre o departamento...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _professors.length,
              itemBuilder: (context, index) {
                final prof = _professors[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      prof['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(prof['department']!),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.meeting_room, size: 20, color: Colors.blueGrey),
                                const SizedBox(width: 8),
                                Text('Ubicación: ${prof['office']}'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.email, size: 20, color: Colors.blueGrey),
                                const SizedBox(width: 8),
                                Text('Correo: ${prof['email']}'),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Ubicando oficina de ${prof['name']} en el mapa...'),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.map_outlined),
                                label: const Text('Ver en Mapa'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
