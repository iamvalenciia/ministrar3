import 'package:ministrar3/services/supabase.dart';
import 'package:location/location.dart';
import 'package:ministrar3/models/help_requests_model/help_requests_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:developer' as developer;

final getHelpRequestsProvider =
    FutureProvider.autoDispose<List<HelpRequestsModel>>((ref) async {
  try {
    Location location = Location();
    late LocationData _locationData;

    _locationData = await location.getLocation();
    developer.log('Location data: $_locationData');

    final response = await supabase.rpc('help_requests', params: {
      'ref_latitude': _locationData.latitude,
      'ref_longitude': _locationData.longitude
    });

    developer.log('RPC response: $response');

    if (response is List) {
      final helpRequests =
          (response).map((json) => HelpRequestsModel.fromJson(json)).toList();
      developer.log('Help requests FROM PROVIDER: $helpRequests');
      return helpRequests;
    } else {
      throw Exception('Unexpected response data: ${response.data}');
    }
  } catch (error) {
    developer.log('An error occurred during Google Sign In', error: error);
    return [];
  }
});
