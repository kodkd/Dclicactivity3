import 'package:flutter/material.dart';

/// Widget réutilisable affichant un texte descriptif sur le magazine.
class SectionTexte extends StatelessWidget {
  final String texte;

  const SectionTexte({super.key, required this.texte});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        texte,
        style: const TextStyle(fontSize: 14, height: 1.5),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
