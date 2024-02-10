import 'package:flutter/material.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:ministrar3/screens/home/navigation_drawer.dart';
import 'package:ministrar3/screens/home/help_requests.dart';
import 'package:ministrar3/screens/home/login_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AppBar')),
      endDrawer: const CustomeNavigationDrawer(),
      body: Column(
        children: [
          if (supabase.auth.currentUser?.id == null) const LoginCard(),
          const HelpRequests(),
        ],
      ),
    );
  }
}
