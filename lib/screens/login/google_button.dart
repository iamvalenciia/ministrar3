import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/activity_provider.dart';
import '../../provider/close_hrs_provider.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/people_helping_provider.dart';
import '../../provider/user_provider.dart';
import '../../utility_functions.dart';

class SigninGoogleButton extends StatelessWidget {
  const SigninGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final UserNotifier userNotifier = context.watch<UserNotifier>();

    final bool isLoggingIn = userNotifier.isLoading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: ElevatedButton(
        onPressed: isLoggingIn
            ? null
            : () {
                try {
                  userNotifier.loginWithGoogle().then((value) async {
                    if (value) {
                      userNotifier.fetchUserProfile().then((_) {
                        if (!context.mounted) {
                          return;
                        }
                        if (userNotifier.user?.username == null) {
                          context.go('/username-form');
                        } else {
                          context.go('/');
                        }
                        Geolocator.checkPermission().then((value) {
                          if (value == LocationPermission.whileInUse ||
                              value == LocationPermission.always) {
                            final MyHelpRequestNotifier myHelpRequestNotifier =
                                context.read<MyHelpRequestNotifier>();
                            final HelpRequestsNotifier helpRequestsNotifier =
                                context.read<HelpRequestsNotifier>();
                            final ActivityNotifier activityNotifier =
                                context.read<ActivityNotifier>();
                            final PeopleHelpingNotifier peopleHelpingNotifier =
                                Provider.of<PeopleHelpingNotifier>(context,
                                    listen: false);
                            Future.wait(
                              [
                                helpRequestsNotifier.fetchHelpRequests(),
                                myHelpRequestNotifier.fetchMyHelpRequest(),
                                activityNotifier.activities(),
                                activityNotifier.fetchMyHelpActivities(),
                                peopleHelpingNotifier
                                    .fetchPeopleHelpingInMyHelpRequest()
                              ],
                            );
                          }
                        });
                      });
                    }
                  });
                } catch (e) {
                  showFlashError(
                      context, 'Error - Signin with Google Button: $e');
                }
              },
        child: isLoggingIn
            ? const LinearProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Image.asset(
                      'assets/app_images/google_logo.png',
                      height: 20,
                    ),
                    const SizedBox(width: 12),
                    const Text('Sign In with Google'),
                  ]),
      ),
    );
  }
}
