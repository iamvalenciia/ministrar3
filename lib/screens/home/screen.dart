import 'package:flutter/material.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:ministrar3/screens/home/navigation_drawer.dart';
import 'package:ministrar3/screens/home/help_requests.dart';
import 'package:ministrar3/screens/home/login_card.dart';
import 'package:ministrar3/screens/home/location_card.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = Location();
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  // Check for location permissions and handle potential exceptions
  void checkLocationPermission() async {
    try {
      _permissionGranted = await location.hasPermission();
      // Trigger a rebuild of the widget after updating _permissionGranted
      setState(() {});
    } catch (e) {
      // Handle exception
      print('Failed to check location permissions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AppBar')),
      endDrawer: const CustomeNavigationDrawer(),
      body: Column(
        children: [
          // Show the LoginCard if the user is not logged in
          if (supabase.auth.currentUser?.id == null) const LoginCard(),
          // Show the LocationCard if location permission is denied
          if (_permissionGranted == PermissionStatus.denied)
            const LocationCard(),
          // Show the HelpRequests if location permission is granted
          if (_permissionGranted == PermissionStatus.granted)
            HelpRequests()
          else
            Text('We need permission to your location to access help requests'),
        ],
      ),
    );
  }
}
