import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:ministrar3/provider/activity_provider.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:ministrar3/provider/permission_provider.dart';
import 'package:ministrar3/provider/user_provider.dart';
import 'package:ministrar3/screens/home/location_card.dart';
import 'package:ministrar3/screens/home/login_card.dart';
import 'package:ministrar3/screens/home/tab_controller.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  Location location = Location();
  static bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    if (_isFirstLoad) {
      // Check if it's the first load
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final helpRequestsNotifier =
            Provider.of<HelpRequestsNotifier>(context, listen: false);
        final userNotifier = Provider.of<UserNotifier>(context, listen: false);
        final myHelpRequestNotifier =
            Provider.of<MyHelpRequestNotifier>(context, listen: false);
        final activityNotifier =
            Provider.of<ActivityNotifier>(context, listen: false);
        final permissionNotifier =
            Provider.of<PermissionProvider>(context, listen: false);
        userNotifier.fetchUserProfile();
        helpRequestsNotifier.fetchHelpRequests();
        myHelpRequestNotifier.fetchMyHelpRequest();
        permissionNotifier.checkLocationPermission();
        activityNotifier.activities();
      });
      _isFirstLoad = false; // Set to false after first load
    }
  }

  @override
  Widget build(BuildContext context) {
    final _permissionGranted =
        context.watch<PermissionProvider?>()?.permissionGranted;
    // Watch for changes

    return RefreshIndicator(
      onRefresh: () async {
        final helpRequestsNotifier =
            Provider.of<HelpRequestsNotifier>(context, listen: false);
        final userNotifier = Provider.of<UserNotifier>(context, listen: false);
        final myHelpRequestNotifier =
            Provider.of<MyHelpRequestNotifier>(context, listen: false);
        final activityNotifier =
            Provider.of<ActivityNotifier>(context, listen: false);
        await helpRequestsNotifier.fetchHelpRequests();
        await userNotifier.fetchUserProfile();
        await myHelpRequestNotifier.fetchMyHelpRequest();
        await activityNotifier.activities();
        // put all this fetches in a notifier class because wee need to called
        // after login with google, because the use profiel is not showing the activity
        // because is not fetching when we logout and log in agian, just fetch when recent open the app
        // and when the user makes a pull to refresh
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Visibility(
                visible: supabase.auth.currentUser?.id == null,
                child: const LoginCard()),
            Visibility(
                visible: _permissionGranted == PermissionStatus.denied,
                child: const LocationCard()),
            Visibility(
              visible: _permissionGranted == PermissionStatus.granted,
              child: SizedBox(
                height: 200,
                child: CustomeTabController(),
              ),
            ),
            Visibility(
                visible: _permissionGranted != PermissionStatus.granted,
                child: Text(
                    'We need permission to your location to access help requests')),
            Text("People I am helping: 0"),
          ],
        ),
      ),
    );
  }
}
