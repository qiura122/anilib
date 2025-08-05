import 'package:anime_library/Widgets/about_page.dart';
import 'package:anime_library/Widgets/browse_page.dart';
import 'package:anime_library/Widgets/profile_page.dart';
import 'package:anime_library/Widgets/settings_page.dart';
import 'package:anime_library/Widgets/notif_page.dart';
import 'package:anime_library/Widgets/add_user.dart';
import 'package:flutter/material.dart';
import 'Pages/dressdarling_page.dart';
import 'Pages/frieren_page.dart';
import 'Pages/horimiya_page.dart';
import 'Pages/komi_page.dart';
import 'Pages/orb_page.dart';
import 'Pages/opm_page.dart';
import 'Pages/jojo_page.dart';
import 'Pages/spyfam_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (value) {
            if (value == 'Add User') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUser()),
              );
            } else if (value == 'About') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            }
          },
          itemBuilder:
              (BuildContext context) => [
                const PopupMenuItem(value: 'Add User', child: Text('Add User')),
                const PopupMenuItem(value: 'About', child: Text('About')),
              ],
        ),
        titleSpacing: 0,
        title: const Text('AniLib'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: AnimeSearchDelegate());
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final List<String> images = [
            'images/frieren.jpg',
            'images/orb.jpg',
            'images/opm.jpg',
            'images/jojo.jpg',
            'images/dressdarling.jpg',
            'images/horimiya.jpg',
            'images/komi.png',
            'images/spyfam.jpg',
          ];
          final List<String> titles = [
            'Sousou no Frieren',
            'Orb: On the Movement of the Earth',
            'One Punch Man',
            'Jojo\'s Bizarre Adventure',
            'My Dress-Up Darling',
            'Horimiya',
            'Komi-san wa, Komyushou desu.',
            'Spy x Family',
          ];

          final List<Widget> pages = [
            FrierenPage(),
            OrbPage(),
            OpmPage(),
            JojoPage(),
            DressDarlingPage(),
            HorimiyaPage(),
            KomiPage(),
            SpyFamPage(),
          ];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pages[index]),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(images[index], fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(titles[index], textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.deepPurpleAccent,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.explore, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrowsePage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AnimeSearchDelegate extends SearchDelegate {
  final List<String> animeList = [
    'Sousou no Frieren',
    'Orb: On the Movement of the Earth',
    'One Punch Man',
    'Jojo\'s Bizarre Adventure',
    'Dress-Darling',
    'Horimiya',
    'Komi-san wa, Komyushou desu.',
    'Spy x Family',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = animeList.where(
      (anime) => anime.toLowerCase().contains(query.toLowerCase()),
    );
    return ListView(
      children:
          results.map<Widget>((anime) => ListTile(title: Text(anime))).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = animeList.where(
      (anime) => anime.toLowerCase().contains(query.toLowerCase()),
    );
    return ListView(
      children:
          suggestions
              .map<Widget>((anime) => ListTile(title: Text(anime)))
              .toList(),
    );
  }
}
