import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';

import '../../provider/activity_provider.dart';
import '../../provider/close_hrs_provider.dart';
import '../../provider/help_points.dart';
import '../../provider/loading_provider.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/people_helping_provider.dart';
import '../../provider/user_provider.dart';
import '../../provider/user_ranking_provider.dart';

class SigninGoogleButton extends StatelessWidget {
  const SigninGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final UserNotifier userNotifier = context.watch<UserNotifier>();
    final loadingNotifier = context.watch<LoadingNotifier>();
    final bool isLoggingIn = userNotifier.isLoading;

    // final bool isLoggingIn = userNotifier.isLoading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: ElevatedButton(
        onPressed: isLoggingIn
            ? null
            : () async {
                loadingNotifier.setLoading(true);
                final contextRead = context.read;
                final messenger = ScaffoldMessenger.of(context);
                final color = Theme.of(context);
                // final navigateTo = GoRouter.of(context);
                final appLocalizations = AppLocalizations.of(context);
                try {
                  await userNotifier.loginWithGoogle();
                  await userNotifier.fetchUserProfile();

                  final permission = await Geolocator.checkPermission();
                  if (permission == LocationPermission.whileInUse ||
                      permission == LocationPermission.always) {
                    final myHelpRequest = contextRead<MyHelpRequestNotifier>();
                    final helpRequests = contextRead<HelpRequestsNotifier>();
                    final activities = contextRead<ActivityNotifier>();
                    final peopleHelping = contextRead<PeopleHelpingNotifier>();
                    final userRankingNotifier =
                        contextRead<UserRankingNotifier>();
                    final HelpPoints helpPoints = contextRead<HelpPoints>();

                    userNotifier.updateLoginStatus();

                    Future.wait(
                      [
                        helpRequests.fetchHelpRequests(),
                        myHelpRequest.fetchMyHelpRequest(),
                        helpPoints.fetchHelpPoints(),
                        // activities.fetchTheLastFourActivities(),
                        activities.fetchWhoIamHelping(),
                        peopleHelping.fetchPeopleHelpingInMyHelpRequest(),
                        userRankingNotifier.fetchUserRakingAndNeighbors()
                      ],
                    );

                    // if (userNotifier.isUserLoggedIn) {
                    //   if (userNotifier.user?.username == null) {
                    //     navigateTo.go('/username-form');
                    //   } else {
                    //     navigateTo.go('/');
                    //   }
                    // }
                  }
                } catch (e) {
                  messenger.showSnackBar(
                    SnackBar(
                      backgroundColor: color.colorScheme.error,
                      content: Text(e.toString()),
                    ),
                  );
                } finally {
                  if (userNotifier.user?.username != null) {
                    messenger.showSnackBar(
                      SnackBar(
                        backgroundColor: color.colorScheme.primary,
                        content: Text(appLocalizations!.loginWithGoogleSuccess),
                      ),
                    );
                  }
                  loadingNotifier.setLoading(false);
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
                    Text(AppLocalizations.of(context)!.loginjoinWithGoogle),
                  ]),
      ),
    );
  }
}
