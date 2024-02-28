import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ministrar3/riverpod/help_requests_provider/help_requests_provider.dart';
import 'dart:developer' as developer;

final streamDistanceProvider = StreamProvider.autoDispose((ref) {
  final distanceStreamController = StreamController<double>.broadcast();

  final StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(
              locationSettings: LocationSettings(distanceFilter: 3))
          .listen((Position position) {
    final userLat = position.latitude;
    final userLong = position.longitude;

    // Access HelpRequests from context if needed
    final helpRequests = ref.watch(getHelpRequestsProvider);

    helpRequests.when(
      data: (data) {
        for (final helpRequest in data) {
          final helpRequestLat = helpRequest.lat ?? 50;
          final helpRequestLong = helpRequest.long ?? 0.0;
          final distanceInMeters = Geolocator.distanceBetween(
              userLat, userLong, helpRequestLat, helpRequestLong);
          distanceStreamController.add(distanceInMeters);
        }
      },
      loading: () => {},
      error: (error, stack) => {},
    );
  });

  ref.onDispose(() {
    positionStream.cancel();
    distanceStreamController.close();
  });

  return distanceStreamController.stream;
});
// fix my CI/CD 

// DIVIDE SCREEN CLOSE TO ME AND MY REQUESTS

// INCLUDE LOGIC TO CREATE REQUESTS WITH JUST MY CURRENT LOCATION

// INCLUDE LOGIC TO HELP
// SHOW IN THE HOME WHO I AM HELPING

// LOGIC TO CALCULATE HOW MANY PEOPLE YOUR HELP

// CHAT LOGIC

// RELEASE