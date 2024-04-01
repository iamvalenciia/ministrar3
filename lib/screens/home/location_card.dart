import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/close_hrs_provider.dart';
import '../../provider/location_permission.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final locationPermissionNotifier =
        Provider.of<LocationPermissionNotifier>(context, listen: false);

    return Card(
      child: ListTile(
        leading: const Icon(Icons.my_location),
        title: const Text('Allow the app to access your location'),
        trailing: TextButton(
          child: const Text('Enable'),
          onPressed: () {
            locationPermissionNotifier.requestLocationPermission().then((_) {
              if (locationPermissionNotifier.hasLocationPermission) {
                // This line of code update the location permission status
                Provider.of<LocationPermissionNotifier>(context, listen: false)
                    .checkLocationPermission();
                // once the permission is granted, we can fetch the help requests
                Provider.of<HelpRequestsNotifier>(context, listen: false)
                    .fetchHelpRequests();
                // Log the location permission status
                developer.log(
                    '${locationPermissionNotifier.hasLocationPermission}',
                    name: 'LocationCard');
              }
            });
          },
        ),
      ),
    );
  }
}
