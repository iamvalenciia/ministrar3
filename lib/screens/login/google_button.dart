import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ministrar3/provider/activity_provider.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:provider/provider.dart';
import 'package:ministrar3/provider/user_provider.dart';

class SigninGoogleButton extends StatelessWidget {
  const SigninGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final helpRequestsNotifier =
        Provider.of<HelpRequestsNotifier>(context, listen: false);
    final userNotifier = Provider.of<UserNotifier>(context, listen: true);
    final myHelpRequestNotifier =
        Provider.of<MyHelpRequestNotifier>(context, listen: false);
    final activityNotifier =
        Provider.of<ActivityNotifier>(context, listen: false);

    final isLoggingIn = userNotifier.isLoading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: ElevatedButton(
        onPressed: isLoggingIn
            ? null
            : () async {
                try {
                  final isLoginSuccessful =
                      await userNotifier.loginWithGoogle();

                  if (isLoginSuccessful) {
                    await helpRequestsNotifier.fetchHelpRequests();
                    await userNotifier.fetchUserProfile();
                    final username = userNotifier.userData?.username;
                    if (username == null) {
                      context.go('/home/account/username-form');
                    } else {
                      context.go('/home');
                    }
                    await myHelpRequestNotifier.fetchMyHelpRequest();
                    await activityNotifier.activities();
                  }
                } catch (e) {
                  // Handle error
                }
              },
        child: isLoggingIn
            ? const LinearProgressIndicator()
            : Row(children: [
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
