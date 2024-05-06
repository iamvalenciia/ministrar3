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
    final UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    final ActivityNotifier activityNotifier =
        Provider.of<ActivityNotifier>(context, listen: false);
    userNotifier.updateLoginStatus();
    Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.whileInUse ||
          value == LocationPermission.always) {
        final HelpRequestsNotifier helpRequestsNotifier =
            Provider.of<HelpRequestsNotifier>(context, listen: false);
        final MyHelpRequestNotifier myHelpRequestNotifier =
            Provider.of<MyHelpRequestNotifier>(context, listen: false);
        final PeopleHelpingNotifier peopleHelpingNotifier =
            Provider.of<PeopleHelpingNotifier>(context, listen: false);

        helpRequestsNotifier.fetchHelpRequests();
        myHelpRequestNotifier.fetchMyHelpRequest();
        peopleHelpingNotifier.fetchPeopleHelpingInMyHelpRequest();
      }
    });

    if (supabase.auth.currentUser?.id != null) {
      await Future.wait([
        userNotifier.fetchUserProfile(),
        activityNotifier.fetchTheLastFourActivities(),
        activityNotifier.fetchHelpActivities(),
      ]);
    }
  }

  @override
  void initState() {
    super.initState();
    if (_isFirstLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        fetchData();
      });
      _isFirstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationPermissionNotifier =
        Provider.of<LocationPermissionNotifier>(context);
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
          Selector<UserNotifier, bool>(
            selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
            builder: (_, userExist, __) => Visibility(
              visible: !userExist,
              child: const LoginCard(),
            ),
          ),
          Visibility(
            visible: !locationPermissionNotifier.hasLocationPermission,
            child: const LocationCard(),
          ),
          Visibility(
            visible: locationPermissionNotifier.hasLocationPermission,
            child: const SizedBox(
              height: 260,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
