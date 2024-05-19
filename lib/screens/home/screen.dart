import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final navigateTo = GoRouter.of(context);
    if (_isFirstLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Check if the user has seen the onboarding screen
        // fetchData();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool hasSeenOnboarding =
            prefs.getBool('hasSeenOnboarding') ?? false;

        if (!hasSeenOnboarding) {
          // If the user hasn't seen the onboarding screen, navigate to it
          navigateTo.go('/onboarding');
        } else {
          // Otherwise, fetch data as usual
          fetchData();
        }
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
      child: Column(
        children: <Widget>[
          Selector<UserNotifier, bool>(
            selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
            builder: (_, userExist, __) => Visibility(
              visible: !userExist &&
                  locationPermissionNotifier.hasLocationPermission,
              child: const LoginCard(),
            ),
          ),
          Visibility(
            visible: !locationPermissionNotifier.hasLocationPermission,
            child: const LocationCard(),
          ),
          Visibility(
            visible: locationPermissionNotifier.hasLocationPermission,
            child: const Expanded(child: CustomeTabController()),
          ),
          Visibility(
            visible: !locationPermissionNotifier.hasLocationPermission,
            child: Center(
              child: Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    AppLocalizations.of(context)!.homePleaseLocation,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
