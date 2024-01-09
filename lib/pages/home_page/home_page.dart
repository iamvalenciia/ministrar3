import 'package:flutter/material.dart';
import 'package:ministrar3/instances/supabase.dart';
import 'package:ministrar3/pages/home_page/navigation_drawer.dart';
import 'package:ministrar3/pages/home_page/help_requests.dart';
import 'package:ministrar3/pages/home_page/login_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
