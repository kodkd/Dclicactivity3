import 'package:flutter/material.dart';

/// Widget réutilisable affichant les rubriques du magazine sous forme de cartes colorées.
class SectionService extends StatelessWidget {
  const SectionService({super.key});

  @override
  Widget build(BuildContext context) {
    final rubriques = [
      {'label': 'Actualité', 'icone': Icons.newspaper, 'couleur': const Color(0xFFD81B60)},
      {'label': 'Science', 'icone': Icons.science, 'couleur': const Color(0xFF8E24AA)},
      {'label': 'Culture', 'icone': Icons.palette, 'couleur': const Color(0xFF1E88E5)},
      {'label': 'Sport', 'icone': Icons.sports_soccer, 'couleur': const Color(0xFF43A047)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: rubriques.map((r) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: (r['couleur'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (r['couleur'] as Color).withOpacity(0.4),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(r['icone'] as IconData,
                        color: r['couleur'] as Color, size: 26),
                    const SizedBox(height: 4),
                    Text(
                      r['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: r['couleur'] as Color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
