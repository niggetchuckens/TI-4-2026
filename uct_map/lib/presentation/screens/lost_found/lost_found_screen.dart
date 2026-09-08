import 'package:flutter/material.dart';

class LostFoundScreen extends StatefulWidget {
  const LostFoundScreen({super.key});

  @override
  State<LostFoundScreen> createState() => _LostFoundScreenState();
}

class _LostFoundScreenState extends State<LostFoundScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCampus = 'Todos los campus';
  String _selectedSort = 'Recientes';
  String _selectedCategory = 'Todos';

  final List<String> _campuses = [
    'Todos los campus',
    'Campus San Juan Pablo II',
    'Campus San Francisco',
    'Campus Dr. Luis Rivas del Canto',
  ];

  final List<String> _sortOptions = ['Recientes', 'Antiguo'];
  final List<String> _categories = ['Todos', 'Documentos', 'Llaves', 'Tecnología', 'Ropa', 'Mochilas'];

  final List<Map<String, dynamic>> _sampleItems = [
    {
      'title': 'Billetera de cuero con carnet y TNE',
      'category': 'Documentos',
      'campus': 'Campus San Juan Pablo II',
      'building': 'Edificio C - Aula C-204',
      'reportedBy': 'Camila Rojas (Estudiante)',
      'timeAgo': 'Hace 45 minutos',
      'ticketNumber': '#TKT-UCT-0842',
      'status': 'PUBLICADO',
      'icon': Icons.badge_outlined,
      'color': Colors.blue,
      'timestamp': 1,
    },
    {
      'title': 'Llavero con 4 llaves y cinta azul UCT',
      'category': 'Llaves',
      'campus': 'Campus San Juan Pablo II',
      'building': 'Edificio Central - Casino',
      'reportedBy': 'Guardia de Seguridad',
      'timeAgo': 'Hace 3 horas',
      'ticketNumber': '#TKT-UCT-0839',
      'status': 'PUBLICADO',
      'icon': Icons.key_outlined,
      'color': Colors.amber,
      'timestamp': 2,
    },
    {
      'title': 'Calculadora Científica Casio fx-991LA',
      'category': 'Tecnología',
      'campus': 'Campus San Francisco',
      'building': 'Edificio A - Laboratorio 2',
      'reportedBy': 'Prof. Rodrigo Alarcón',
      'timeAgo': 'Ayer',
      'ticketNumber': '#TKT-UCT-0820',
      'status': 'PUBLICADO',
      'icon': Icons.calculate_outlined,
      'color': Colors.purple,
      'timestamp': 3,
    },
    {
      'title': 'Polerón azul marino UCT Talla L',
      'category': 'Ropa',
      'campus': 'Campus San Juan Pablo II',
      'building': 'Gimnasio / Canchas Deportivas',
      'reportedBy': 'Matías Soto (Estudiante)',
      'timeAgo': 'Hace 2 días',
      'ticketNumber': '#TKT-UCT-0811',
      'status': 'PUBLICADO',
      'icon': Icons.checkroom_outlined,
      'color': Colors.teal,
      'timestamp': 4,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();

    // Filtros
    var filteredItems = _sampleItems.where((item) {
      final matchesQuery = query.isEmpty ||
          (item['title'] as String).toLowerCase().contains(query) ||
          (item['building'] as String).toLowerCase().contains(query) ||
          (item['ticketNumber'] as String).toLowerCase().contains(query) ||
          (item['reportedBy'] as String).toLowerCase().contains(query);

      final matchesCampus = _selectedCampus == 'Todos los campus' ||
          item['campus'] == _selectedCampus;

      final matchesCat = _selectedCategory == 'Todos' ||
          item['category'] == _selectedCategory;

      return matchesQuery && matchesCampus && matchesCat;
    }).toList();

    // Ordenar
    if (_selectedSort == 'Antiguo') {
      filteredItems.sort((a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int));
    } else {
      filteredItems.sort((a, b) => (a['timestamp'] as int).compareTo(b['timestamp'] as int));
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Buscador
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF003865)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Buscar por nombre, ticket o lugar...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 20, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // 2. Menú desplegable para seleccionar el campus
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCampus,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF003865)),
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  items: _campuses.map((campus) {
                    return DropdownMenuItem<String>(
                      value: campus,
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 18, color: Color(0xFF003865)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              campus,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCampus = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 14),

            // 3. Ordenar por y botones de filtro
            Row(
              children: [
                const Icon(Icons.tune_outlined, size: 18, color: Color(0xFF003865)),
                const SizedBox(width: 6),
                const Text(
                  'Ordenar por:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(width: 8),
                // Botones Recientes / Antiguo
                ..._sortOptions.map((sort) {
                  final isSelected = _selectedSort == sort;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: ChoiceChip(
                      label: Text(sort),
                      selected: isSelected,
                      selectedColor: const Color(0xFF003865),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF1E293B),
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (val) {
                        setState(() {
                          _selectedSort = sort;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 8),

            // Categorías horizontales: Todos, Documentos, Llaves, etc.
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: const Color(0xFF003865).withValues(alpha: 0.15),
                      checkmarkColor: const Color(0xFF003865),
                      labelStyle: TextStyle(
                        color: isSelected ? const Color(0xFF003865) : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12.5,
                      ),
                      onSelected: (val) {
                        setState(() {
                          _selectedCategory = cat;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // 4. Lista de recuadros de objetos
            if (filteredItems.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.inventory_2_outlined, size: 60, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text(
                        'No hay objetos publicados con estos filtros.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return _buildObjectCard(context, item);
                },
              ),
          ],
        ),
      ),
    );
  }

  // Recuadro del objeto con todos los datos requeridos
  Widget _buildObjectCard(BuildContext context, Map<String, dynamic> item) {
    final color = item['color'] as Color;

    return Card(
      elevation: 2.5,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Área de imagen del objeto con el estado PUBLICADO en grande arriba
          Stack(
            children: [
              // Contenedor de la imagen (con placeholder estilizado de alta calidad)
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.15),
                      color.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: Icon(item['icon'] as IconData, size: 36, color: color),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['category'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ESTADO PUBLICADO EN GRANDE
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981), // Verde esmeralda vivo
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    item['status'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              // Número de ticket arriba a la derecha
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['ticketNumber'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Información del objeto dentro del recuadro
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre del objeto
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 10),

                // Reportado por
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 16, color: Color(0xFF003865)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Reportado por: ${item['reportedBy']}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Edificio
                Row(
                  children: [
                    const Icon(Icons.apartment_outlined, size: 16, color: Color(0xFF003865)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${item['building']} • ${item['campus']}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Hace cuánto se publicó
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      'Publicado ${item['timeAgo']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Botón de acción
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Contactando punto de entrega para ${item['ticketNumber']}...'),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF003865),
                      side: const BorderSide(color: Color(0xFF003865), width: 1.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    icon: const Icon(Icons.info_outline, size: 18),
                    label: const Text(
                      'Ver detalle y reclamar',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
