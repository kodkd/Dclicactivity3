import 'package:cloud_firestore/cloud_firestore.dart';


class Redacteur {
  final String id;
  final String nom;
  final String specialite;

  Redacteur({
    required this.id,
    required this.nom,
    required this.specialite,
  });

  /// Crée un objet Redacteur depuis un document Firestore.
  factory Redacteur.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Redacteur(
      id: doc.id,
      nom: data['nom'] ?? '',
      specialite: data['specialite'] ?? '',
    );
  }

  /// Convertit l'objet en Map pour l'envoi à Firestore.
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'specialite': specialite,
    };
  }
}
