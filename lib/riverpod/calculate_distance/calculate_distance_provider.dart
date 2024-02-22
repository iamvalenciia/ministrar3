import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ministrar3/models/help_requests_model/help_requests_model.dart';
import 'dart:developer' as developer;

final streamDistanceProvider = StreamProvider.autoDispose
    .family<double, HelpRequestsModel>((ref, helpRequest) async* {
  final StreamController<double> controller =
      StreamController<double>.broadcast();

  StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
          locationSettings: LocationSettings(distanceFilter: 1))
      .listen((Position position) {
    final double userLat = position.latitude;
    final double userLong = position.longitude;
    final double helpRequestLat = helpRequest.lat ?? 50;
    final double helpRequestLong = helpRequest.long ?? 0.0;
    // Use current location
    double distanceInMeters = Geolocator.distanceBetween(
        userLat, userLong, helpRequestLat, helpRequestLong);
    controller.add(distanceInMeters);

    // Log the current location and distance
    developer.log('Current location: $userLat, $userLong');
    developer.log('Distance to help request: $distanceInMeters meters');
  });

  ref.onDispose(() {
    positionStream.cancel();
    controller.close();
    // Log that the provider has been disposed
    developer.log('streamDistanceProvider disposed');
  });

  yield* controller.stream;
});

// the problem is from here
// the position.latitude and position.longitud still are de same

// posible errors:
// my laptops is not connected to the location of the simulator android
// Missing some configurations here
// it is setup to update location when the divice move 1 meter
// I move some metter and didn't update, but I think because for some reason
// my simulator android is not recognizing when I move with my laptop


// Posible solution test in a real device