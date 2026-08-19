import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const AZKomekciApp());
}

class AZKomekciApp extends StatefulWidget {
  const AZKomekciApp({super.key});

  @override
  State<AZKomekciApp> createState() => _AZKomekciAppState();
}

class _AZKomekciAppState extends State<AZKomekciApp> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      themeMode =
          themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AZ Köməkçi',
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1478E9),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1478E9),
          brightness: Brightness.dark,
        ),
      ),
      home: MainScreen(
        onThemeChanged: toggleTheme,
        isDark: themeMode == ThemeMode.dark,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDark;

  const MainScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDark,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
    final List<Widget> pages = const [
  HomePage(),
  MapPage(),
  FavoritesPage(),
  ProfilePage(),
  AssistantPage(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Ana səhifə',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Xəritə',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border),
            selectedIcon: Icon(Icons.star),
            label: 'Seçilmiş',
          ),
NavigationDestination(
  icon: Icon(Icons.smart_toy_outlined),
  selectedIcon: Icon(Icons.smart_toy),
  label: 'Köməkçi',
),
        ],
      ),
    );
  }
}
class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Köməkçi'),
      ),
      body: const Center(
        child: Text(
          'AZ Köməkçi hazırdır!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';

  final List<Category> categories = const [
    Category(
      title: 'Xəstəxanalar',
      icon: Icons.local_hospital,
      color: Color(0xFFE53935),
    ),
    Category(
      title: 'Apteklər',
      icon: Icons.medication,
      color: Color(0xFF43A047),
    ),
    Category(
      title: 'Nəqliyyat',
      icon: Icons.directions_bus,
      color: Color(0xFF1E88E5),
    ),
    Category(
      title: 'Dövlət xidmətləri',
      icon: Icons.account_balance,
      color: Color(0xFF8E24AA),
    ),
    Category(
      title: 'Xidmətlər',
      icon: Icons.build,
      color: Color(0xFFFB8C00),
    ),
    Category(
      title: 'İş elanları',
      icon: Icons.work,
      color: Color(0xFF00897B),
    ),
  Category(
  title: 'Xəritə',
  icon: Icons.map,
  color: Color(0xFF4CAF50),
),
];
  @override
  Widget build(BuildContext context) {
    final filtered = categories
        .where(
          (item) =>
              item.title.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF1478E9),
                              Color(0xFF00A86B),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'AZ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'AZ Köməkçi',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Salam! 👋',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Sizə necə kömək edə bilərik?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.65),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Axtarış...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Kateqoriyalar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Hamısı'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          SliverPadding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  sliver: SliverGrid(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        final category = filtered[index];

        return CategoryCard(
          category: category,
          onTap: () {
            if (category.title == 'Xəstəxanalar') {
              Navigator.push(
                context,
                MaterialPageRoute(
builder: (_) => HospitalPage(),
                ),
              );
            } else if (category.title == 'Xəritə') {
              Navigator.push(
                context,
                MaterialPageRoute(
builder: (_) => AzerbaijanMapPage(),
                ),
              );
            } else {
              showCategoryMessage(
                context,
                category.title,
              );
            }
          },
        );
      },
      childCount: filtered.length,
    ),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 1.15,
    ),
  ),
),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 5),

                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      showCategoryMessage(
                        context,
                        'Yaxınımda',
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1478E9),
                            Color(0xFF0758B5),
                          ],
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 34,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Yaxınımda nə var?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Xəstəxana, aptek, mağaza və daha çox',
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String title;
  final IconData icon;
  final Color color;

  const Category({
    required this.title,
    required this.icon,
    required this.color,
  });
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: const Offset(0, 5),
              color: Colors.black.withOpacity(.06),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: category.color.withOpacity(.12),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                category.icon,
                color: category.color,
                size: 26,
              ),
            ),
            const Spacer(),
            Text(
              category.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCategoryMessage(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$title bölməsi hazırlanır 🚀'),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

class HospitalsPage extends StatelessWidget {
  const HospitalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospitals Page'),
      ),
      body: const Center(
        child: Text(
          'Xəstəxanalar',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🗺️ Xəritə'),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(40.1431, 47.5769),
          initialZoom: 6.5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.azkomekci.app',
          ),
        ],
      ),
    );
  }
}
class HospitalPage extends StatelessWidget {
  const HospitalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xəstəxanalar'),
      ),
      body: const Center(
        child: Text(
          '🏥 Xəstəxanalar bölməsi hazırlanır',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class AzerbaijanMapPage extends StatelessWidget {
  const AzerbaijanMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Azərbaycan xəritəsi'),
      ),
      body: const Center(
        child: Text(
          '🇦🇿 Azərbaycan xəritəsi hazırlanır',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '⭐ Seçilmişlər\n\nBurada seçdiyiniz yerlər olacaq',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '👤 Profil\n\nProfil bölməsi hazırlanır',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
