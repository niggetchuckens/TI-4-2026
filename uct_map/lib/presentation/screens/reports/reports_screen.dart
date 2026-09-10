import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.amber.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.amber.shade200),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.amber, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Reporta problemas en salas, ascensores, accesibilidad o infraestructura del campus.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Mis Reportes Recientes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildReportItem(
            title: 'Proyector con falla técnica',
            location: 'Sala C-201, Edificio C',
            date: '05 Septiembre, 2026',
            status: 'En Revisión',
            statusColor: Colors.orange,
          ),
          _buildReportItem(
            title: 'Luz intermitente en pasillo',
            location: 'Piso 2, Edificio B',
            date: '02 Septiembre, 2026',
            status: 'Resuelto',
            statusColor: Colors.green,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'reports_fab',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Formulario para nuevo reporte')),
          );
        },
        icon: const Icon(Icons.add_alert_outlined),
        label: const Text('Nuevo Reporte'),
      ),
    );
  }

  Widget _buildReportItem({
    required String title,
    required String location,
    required String date,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('$location\n$date'),
        isThreeLine: true,
        trailing: Chip(
          label: Text(
            status,
            style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          backgroundColor: statusColor.withValues(alpha: 0.1),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
