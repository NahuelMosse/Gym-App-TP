import 'package:flutter/material.dart';
import '../page/home_page.dart';
import '../page/dumbbell_page.dart';
import '../page/profile_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Definí las claves para acceder al estado interno de cada página
  final GlobalKey<HomePageState> homeKey = GlobalKey<HomePageState>();
  final GlobalKey<DumbbellPageState> dumbbellKey =
      GlobalKey<DumbbellPageState>();
  final GlobalKey<ProfilePageState> profileKey = GlobalKey<ProfilePageState>();

  // Tus tres páginas principales
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(key: homeKey),
      DumbbellPage(key: dumbbellKey),
      ProfilePage(key: profileKey),
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      // 🔔 Llama una función dentro de la página actual
      switch (index) {
        case 0:
          homeKey.currentState?.scrollToTop();
          break;
        case 1:
          dumbbellKey.currentState?.refreshData();
          break;
        case 2:
          profileKey.currentState?.refreshData();
          break;
      }
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Dumbbell',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
