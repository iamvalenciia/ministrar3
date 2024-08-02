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
      title: const Text('Ministrar'),
    ),
    AppBar(
      title: const Text('People helping'),
      leading: const Icon(Icons.business),
    ),
    AppBar(
      title: const Text('Business'),
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
      // if the index is 0, we don't want to show the app bar
      // 0 == HomeScreen
      appBar: _selectedIndex == 0 ? null : appBarOptions[_selectedIndex],
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.group),
            label: 'Helping',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
