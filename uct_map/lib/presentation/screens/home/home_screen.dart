import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigateToTab;

  const HomeScreen({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio - UCT Map'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner de bienvenida
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '¡Bienvenido a UCT Map!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Encuentra tus salas, edificios, oficinas de profesores y más.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Accesos Rápidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Grid de accesos directos
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildQuickActionCard(
                  context,
                  icon: Icons.map_outlined,
                  title: 'Ver Mapa',
                  subtitle: 'Explorar campus',
                  color: Colors.blue,
                  onTap: () => onNavigateToTab(1),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.search,
                  title: 'Buscar Salas',
                  subtitle: 'Aulas y laboratorios',
                  color: Colors.orange,
                  onTap: () => onNavigateToTab(2),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.school_outlined,
                  title: 'Profesores',
                  subtitle: 'Directorio y oficinas',
                  color: Colors.green,
                  onTap: () => Navigator.pushNamed(context, '/professors'),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.report_problem_outlined,
                  title: 'Reportes',
                  subtitle: 'Reportar incidencias',
                  color: Colors.redAccent,
                  onTap: () => Navigator.pushNamed(context, '/reports'),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.find_in_page_outlined,
                  title: 'Objetos Perdidos',
                  subtitle: 'Consultar o reportar',
                  color: Colors.purple,
                  onTap: () => Navigator.pushNamed(context, '/lost-found'),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.person_outline,
                  title: 'Mi Perfil',
                  subtitle: 'Datos de usuario',
                  color: Colors.teal,
                  onTap: () => onNavigateToTab(3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.15),
                radius: 24,
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
