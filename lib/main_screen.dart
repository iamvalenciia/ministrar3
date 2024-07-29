import 'package:flutter/material.dart';
// For nested navigation
import 'screens/home/screen.dart';
import 'screens/profile/screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreenBody(),
    const ProfileScreen(),
  ];

  final List<AppBar> appBarOptions = <AppBar>[
    AppBar(
      title: const Text('Home'),
      leading: const Icon(Icons.home),
    ),
    AppBar(
      title: const Text('Business'),
      leading: const Icon(Icons.business),
    ),
    AppBar(
      title: const Text('School'),
      leading: const Icon(Icons.school),
    ),
    AppBar(
      title: const Text('Settings'),
      leading: const Icon(Icons.settings),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOptions[_selectedIndex],
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
