import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';


class AjoutRedacteurPage extends StatefulWidget {
  final RedacteurController controller;

  const AjoutRedacteurPage({super.key, required this.controller});

  @override
  State<AjoutRedacteurPage> createState() => _AjoutRedacteurPageState();
}

class _AjoutRedacteurPageState extends State<AjoutRedacteurPage> {
  // Clé globale pour valider le formulaire
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour récupérer les valeurs des champs de texte
  final _nomController = TextEditingController();
  final _specialiteController = TextEditingController();

  bool _chargement = false;

  // Style du bouton d'ajout
  final ButtonStyle _styleBouton = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFD81B60),
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  /// Valide le formulaire et envoie les données au contrôleur.
  Future<void> _ajouterRedacteur() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _chargement = true);

    try {
      await widget.controller.ajouterRedacteur(
        _nomController.text.trim(),
        _specialiteController.text.trim(),
      );
      if (mounted) _afficherSuccesDialog();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  /// Affiche une boîte de dialogue de succès après l'ajout.
  void _afficherSuccesDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Succès'),
        content: const Text('Rédacteur ajouté avec succès !'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer le dialog
              Navigator.of(context).pop(); // Retourner à la page précédente
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFFD81B60))),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Libérer les ressources des contrôleurs pour éviter les fuites mémoire
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter un Rédacteur',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD81B60),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Champ Nom
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  prefixIcon:
                      const Icon(Icons.person, color: Color(0xFFD81B60)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xFFD81B60), width: 2),
                  ),
                ),
                validator: (valeur) {
                  if (valeur == null || valeur.trim().isEmpty) {
                    return 'Veuillez entrer le nom du rédacteur.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Champ Spécialité
              TextFormField(
                controller: _specialiteController,
                decoration: InputDecoration(
                  labelText: 'Spécialité',
                  prefixIcon:
                      const Icon(Icons.work, color: Color(0xFFD81B60)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xFFD81B60), width: 2),
                  ),
                ),
                validator: (valeur) {
                  if (valeur == null || valeur.trim().isEmpty) {
                    return 'Veuillez entrer la spécialité du rédacteur.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Bouton d'ajout
              _chargement
                  ? const CircularProgressIndicator(
                      color: Color(0xFFD81B60))
                  : ElevatedButton(
                      style: _styleBouton,
                      onPressed: _ajouterRedacteur,
                      child: const Text(
                        'Ajouter le rédacteur',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
