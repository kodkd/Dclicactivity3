import 'package:flutter/material.dart';

/// Widget réutilisable affichant les icônes de contact (Tel, Mail, Partage).
class SectionIcone extends StatelessWidget {
  const SectionIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconeItem(Icons.phone, 'TEL'),
          _buildIconeItem(Icons.email, 'MAIL'),
          _buildIconeItem(Icons.share, 'PARTAGE'),
        ],
      ),
    );
  }

  Widget _buildIconeItem(IconData icone, String label) {
    return Column(
      children: [
        Icon(icone, color: const Color(0xFFD81B60), size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
