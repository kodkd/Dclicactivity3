import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../models/redacteur.dart';


class ModifierRedacteurPage extends StatefulWidget {
  final Redacteur redacteur;
  final RedacteurController controller;

  const ModifierRedacteurPage({
    super.key,
    required this.redacteur,
    required this.controller,
  });

  @override
  State<ModifierRedacteurPage> createState() => _ModifierRedacteurPageState();
}

class _ModifierRedacteurPageState extends State<ModifierRedacteurPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomController;
  late final TextEditingController _specialiteController;
  bool _chargement = false;

  @override
  void initState() {
    super.initState();

    _nomController = TextEditingController(text: widget.redacteur.nom);
    _specialiteController =
        TextEditingController(text: widget.redacteur.specialite);
  }

  /// Valide et envoie les modifications au contrôleur.
  Future<void> _enregistrerModifications() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _chargement = true);

    try {
      await widget.controller.modifierRedacteur(
        widget.redacteur.id,
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

  void _afficherSuccesDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Succès'),
        content: const Text('Rédacteur modifié avec succès !'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFFD81B60))),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Modifier le Rédacteur',
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
              // Champ Nom prérempli
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

              // Champ Spécialité prérempli
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

              _chargement
                  ? const CircularProgressIndicator(color: Color(0xFFD81B60))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD81B60),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: _enregistrerModifications,
                      child: const Text(
                        'Enregistrer les modifications',
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
