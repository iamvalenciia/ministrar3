import 'package:flutter/material.dart';
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

  Widget conditional(bool condition, Widget widget) {
    return condition ? widget : Container();
  }

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
        activityNotifier.fetchPostActivity();
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
        await activityNotifier.fetchPostActivity();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            conditional(
                supabase.auth.currentUser?.id == null, const LoginCard()),
            conditional(_permissionGranted == PermissionStatus.denied,
                const LocationCard()),
            SizedBox(
              height: 200,
              child: conditional(_permissionGranted == PermissionStatus.granted,
                  CustomeTabController()),
            ),
            conditional(
                _permissionGranted != PermissionStatus.granted,
                Text(
                    'We need permission to your location to access help requests')),
            Text("People I am helping: 0"),
          ],
        ),
      ),
    );
  }
}
