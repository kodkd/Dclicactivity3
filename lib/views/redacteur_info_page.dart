import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../models/redacteur.dart';
import 'modifier_redacteur_page.dart';
import 'supprimer_redacteur_page.dart';


class RedacteurInfoPage extends StatelessWidget {
  final RedacteurController controller;

  const RedacteurInfoPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Informations des Rédacteurs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD81B60),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.redacteursStream,
        builder: (context, snapshot) {
          // Indicateur de chargement pendant la connexion à Firestore
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFD81B60)),
            );
          }

          // Gestion des erreurs Firestore
          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur : ${snapshot.error}',
                  style: const TextStyle(color: Colors.red)),
            );
          }

          // Message si la collection est vide
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'Aucun rédacteur trouvé.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // Conversion des documents Firestore en objets Redacteur
          final redacteurs = snapshot.data!.docs
              .map((doc) => Redacteur.fromFirestore(doc))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: redacteurs.length,
            itemBuilder: (context, index) {
              final redacteur = redacteurs[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFD81B60).withOpacity(0.15),
                    child: const Icon(Icons.person, color: Color(0xFFD81B60)),
                  ),
                  title: Text(
                    redacteur.nom,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(redacteur.specialite),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icône de modification
                      IconButton(
                        icon:
                            const Icon(Icons.edit, color: Color(0xFFD81B60)),
                        tooltip: 'Modifier',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ModifierRedacteurPage(
                                redacteur: redacteur,
                                controller: controller,
                              ),
                            ),
                          );
                        },
                      ),
                      // Icône de suppression
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Supprimer',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SupprimerRedacteurPage(
                                redacteur: redacteur,
                                controller: controller,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
