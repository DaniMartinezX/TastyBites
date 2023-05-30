import 'package:flutter/material.dart';
import 'package:tasty_bites/pages/favorites_page.dart';
import 'package:tasty_bites/pages/profile_page.dart';
import 'package:tasty_bites/pages/random_food_page.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _screens = const [
    RandomFoodPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(15),
        child: SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                  30), // Ajusta los valores según tu preferencia
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              unselectedItemColor: Colors.white,
              selectedItemColor: const Color.fromARGB(255, 255, 191, 0),
              backgroundColor:
                  const Color.fromARGB(255, 234, 79, 32).withOpacity(0.8),
              currentIndex: _currentIndex,
              onTap: (int newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                  _pageController.animateToPage(
                    newIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Random',
                  icon: Icon(Icons.shuffle),
                ),
                BottomNavigationBarItem(
                  label: 'Favorites',
                  icon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
