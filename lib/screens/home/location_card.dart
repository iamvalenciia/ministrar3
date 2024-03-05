import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.my_location),
        title: Row(
          children: [
            const Expanded(
              child: Text('Allow the app to access your location'),
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Text('Enable'),
              onPressed: () async {
                LocationPermission permission =
                    await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission != LocationPermission.whileInUse &&
                      permission != LocationPermission.always) {
                    return;
                  }
                }

                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
