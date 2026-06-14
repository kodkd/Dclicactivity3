import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../models/redacteur.dart';


class SupprimerRedacteurPage extends StatelessWidget {
  final Redacteur redacteur;
  final RedacteurController controller;

  const SupprimerRedacteurPage({
    super.key,
    required this.redacteur,
    required this.controller,
  });

  /// Appelle le contrôleur pour supprimer puis affiche une confirmation.
  Future<void> _supprimerRedacteur(BuildContext context) async {
    try {
      await controller.supprimerRedacteur(redacteur.id);
      if (context.mounted) _afficherSuccesDialog(context);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _afficherSuccesDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Suppression réussie'),
        content: Text(
            'Le rédacteur "${redacteur.nom}" a été supprimé.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer le dialog
              Navigator.of(context).pop(); // Retourner à la liste
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFFD81B60))),
          ),
        ],
      ),
    );
  }

  // Style personnalisé du bouton de suppression

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Supprimer le Rédacteur',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_amber_rounded,
                color: Colors.orange, size: 72),
            const SizedBox(height: 24),

            Text(
              'Voulez-vous vraiment supprimer le rédacteur "${redacteur.nom}" ?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 8),

            Text(
              'Spécialité : ${redacteur.specialite}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            const SizedBox(height: 32),

            // Bouton de confirmation de suppression
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.delete),
                label: const Text('Supprimer le rédacteur',
                    style: TextStyle(fontSize: 16)),
                onPressed: () => _supprimerRedacteur(context),
              ),
            ),

            const SizedBox(height: 12),

            // Bouton d'annulation
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Annuler', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
