import 'package:flutter/material.dart';
import 'package:ministrar3/provider/help_req_provider.dart';
import 'package:ministrar3/provider/user_provider.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:ministrar3/screens/home/navigation_drawer.dart';
import 'package:ministrar3/screens/home/tab_controller.dart';
import 'package:ministrar3/screens/home/login_card.dart';
import 'package:ministrar3/screens/home/location_card.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = Location();
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  static bool _isFirstLoad = true; // Add this line

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
    if (_isFirstLoad) {
      // Check if it's the first load
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final helpRequestsNotifier =
            Provider.of<HelpRequestsNotifier>(context, listen: false);
        final userNotifier = Provider.of<UserProvider>(context, listen: false);
        helpRequestsNotifier.fetchHelpRequests();
        userNotifier.fetchUserProfile();
      });
      _isFirstLoad = false; // Set to false after first load
    }
  }

  // Check for location permissions and handle potential exceptions
  void checkLocationPermission() async {
    try {
      _permissionGranted = await location.hasPermission();
      setState(() {});
    } catch (e) {
      print('Failed to check location permissions: $e');
    }
  }

  Widget conditional(bool condition, Widget widget) {
    return condition ? widget : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final helpRequestsNotifier =
            Provider.of<HelpRequestsNotifier>(context, listen: false);
        final userNotifier = Provider.of<UserProvider>(context, listen: false);
        await helpRequestsNotifier.fetchHelpRequests();
        await userNotifier.fetchUserProfile();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Ministrar')),
        endDrawer: const CustomeNavigationDrawer(),
        body: ListView(
          children: [
            conditional(
                supabase.auth.currentUser?.id == null, const LoginCard()),
            conditional(_permissionGranted == PermissionStatus.denied,
                const LocationCard()),
            SizedBox(
              height: 200,
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
      ),
    );
  }
}
