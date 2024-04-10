import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'provider/close_hrs_provider.dart';
import 'provider/my_hr_provider.dart';

// This function checks location permissions and fetches help requests if allowed
void checkPermissionsAndFetchRequests(BuildContext context) {
  Geolocator.checkPermission().then((value) {
    if (value == LocationPermission.whileInUse ||
        value == LocationPermission.always) {
      final helpRequestsNotifier = context.read<HelpRequestsNotifier>();
      final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
      myHelpRequestNotifier.clearHelpRequest();
      helpRequestsNotifier.fetchHelpRequests();
    }
  });
}

void showFlashError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(message),
    ),
  );
  developer.log(name: 'showFlashError', message);
}

// create a sucess message
void showFlashSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Text(message),
    ),
  );
  developer.log(name: 'showFlashSuccess', message);
}
