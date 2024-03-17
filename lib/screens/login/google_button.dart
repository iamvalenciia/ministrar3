import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:provider/provider.dart';
import 'package:ministrar3/provider/user_provider.dart';

class SigninGoogleButton extends StatelessWidget {
  const SigninGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserNotifier>();
    final helpRequestsNotifier = context.watch<HelpRequestsNotifier>();
    final myHelpRequestNotifier = context.watch<MyHelpRequestNotifier>();

    final isLoggingIn = userProvider.isLoading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: ElevatedButton(
        onPressed: isLoggingIn
            ? null
            : () async {
                try {
                  final isLoginSuccessful =
                      await userProvider.loginWithGoogle();

                  if (isLoginSuccessful) {
                    await userProvider.fetchUserProfile();
                    await helpRequestsNotifier.fetchHelpRequests();
                    await myHelpRequestNotifier.fetchMyHelpRequest();
                    final username = userProvider.userModel?.username;
                    if (username == null) {
                      context.go('/home/account/username-form');
                    } else {
                      context.go('/home');
                    }
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
