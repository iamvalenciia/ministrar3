import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../provider/activity_provider.dart';
import '../../provider/close_hrs_provider.dart';
import '../../provider/location_permission.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/people_helping_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/supabase.dart';
import '../../utility_functions.dart';
import 'location_card.dart';
import 'login_card.dart';
import 'tab_controller.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  static bool _isFirstLoad = true;

  Future<void> fetchData() async {
    developer.log('Fetching data', name: 'HomeScreenBody');
    final UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    final ActivityNotifier activityNotifier =
        Provider.of<ActivityNotifier>(context, listen: false);

    Geolocator.checkPermission().then((value) {
      developer.log('Permission status: $value', name: 'HelpRequestsNotifier');
      if (value == LocationPermission.whileInUse ||
          value == LocationPermission.always) {
        developer.log('before declare the help request notifier');
        final HelpRequestsNotifier helpRequestsNotifier =
            Provider.of<HelpRequestsNotifier>(context, listen: false);
        developer.log('before declare the MY HELP REQUEST NOTIFIER');
        final MyHelpRequestNotifier myHelpRequestNotifier =
            Provider.of<MyHelpRequestNotifier>(context, listen: false);
        final PeopleHelpingNotifier peopleHelpingNotifier =
            Provider.of<PeopleHelpingNotifier>(context, listen: false);

        developer.log('before fetch help request');
        helpRequestsNotifier.fetchHelpRequests();
        developer.log('before fetch My help request');
        myHelpRequestNotifier.fetchMyHelpRequest();
        peopleHelpingNotifier.fetchPeopleHelpingInMyHelpRequest();
      }
    });

    if (supabase.auth.currentUser?.id != null) {
      await Future.wait([
        userNotifier.fetchUserProfile(),
        activityNotifier.activities(),
        activityNotifier.fetchMyHelpActivities(),
      ]);
    }
  }

  @override
  void initState() {
    super.initState();
    if (_isFirstLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Provider.of<LocationPermissionNotifier>(context, listen: false)
        //     .checkLocationPermission();
        fetchData();
      });
      _isFirstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    developer.log('Building HomeScreenBody');
    final locationPermissionNotifier =
        Provider.of<LocationPermissionNotifier>(context);
    final UserNotifier userNotifier = context.watch<UserNotifier>();
    return RefreshIndicator(
      onRefresh: () async {
        try {
          fetchData();
        } catch (e) {
          if (!context.mounted) {
            return;
          }
          showFlashError(context, 'Error fetching data in the Home screen: $e');
        }
      },
      child: ListView(
        children: <Widget>[
          Visibility(
            visible: !userNotifier.isUserLoggedIn,
            child: const LoginCard(),
          ),
          Visibility(
            visible: !locationPermissionNotifier.hasLocationPermission,
            child: const LocationCard(),
          ),
          Visibility(
            visible: locationPermissionNotifier.hasLocationPermission,
            child: const SizedBox(
              height: 200,
              child: CustomeTabController(),
            ),
          ),
          Visibility(
            visible: !locationPermissionNotifier.hasLocationPermission,
            child: const Center(
              child: Card.outlined(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: const Text(
                    'Please enable location permission to view nearby help requests',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
