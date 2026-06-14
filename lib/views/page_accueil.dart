import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../widgets/section_titre.dart';
import '../widgets/section_texte.dart';
import '../widgets/section_icone.dart';
import '../widgets/section_service.dart';
import 'ajout_redacteur_page.dart';
import 'redacteur_info_page.dart';


class PageAccueil extends StatelessWidget {
  // Le contrôleur est instancié ici et partagé par injection de dépendance.
  final RedacteurController _controller = RedacteurController();

  PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Magazine Infos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFD81B60),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      // ── Drawer de navigation ──────────────────────────────────────────────
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFD81B60)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.menu_book, color: Colors.white, size: 40),
                  SizedBox(height: 8),
                  Text(
                    'Magazine Infos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_add, color: Color(0xFFD81B60)),
              title: const Text('Ajouter un Rédacteur'),
              onTap: () {
                Navigator.pop(context); // Fermer le Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AjoutRedacteurPage(controller: _controller),
                  ),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.people, color: Color(0xFFD81B60)),
              title: const Text('Informations des Rédacteurs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RedacteurInfoPage(controller: _controller),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bannière image de couverture
            Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFD81B60), Color(0xFF8E24AA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(Icons.menu_book, size: 80, color: Colors.white70),
              ),
            ),

            const SizedBox(height: 8),

            const SectionTitre(
              titre: 'Bienvenue au Magazine Infos',
              description: 'Votre magazine numérique, votre source d\'inspiration',
            ),

            const SectionTexte(
              texte:
                  'Magazine Infos est bien plus qu\'un simple magazine d\'informations. '
                  'C\'est votre passerelle vers le monde, une source inestimable de connaissances '
                  'et d\'actualités soigneusement sélectionnées pour vous éclairer sur les enjeux '
                  'mondiaux, la culture, la science et même le divertissement.',
            ),

            const SectionIcone(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Nos rubriques',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD81B60),
                ),
              ),
            ),

            const SectionService(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
