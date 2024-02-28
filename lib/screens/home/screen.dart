import 'package:flutter/material.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:ministrar3/screens/home/navigation_drawer.dart';
import 'package:ministrar3/screens/home/tab_controller.dart';
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

  Widget conditional(bool condition, Widget widget) {
    return condition ? widget : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ministrar')),
      endDrawer: const CustomeNavigationDrawer(),
      body: Column(
        children: [
          conditional(supabase.auth.currentUser?.id == null, const LoginCard()),
          conditional(_permissionGranted == PermissionStatus.denied,
              const LocationCard()),
          Expanded(
            child: conditional(_permissionGranted == PermissionStatus.granted,
                CustomeTabController()),
          ),
          conditional(
              _permissionGranted != PermissionStatus.granted,
              Text(
                  'We need permission to your location to access help requests')),
          Text("People I am helping: 0"),
        ],
      ),
    );
  }
}
