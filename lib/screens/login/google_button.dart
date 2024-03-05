import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ministrar3/provider/user_provider.dart';

class SigninGoogleButton extends StatelessWidget {
  const SigninGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
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
                    final username = userProvider.userModel?.username;
                    if (username == null) {
                      Navigator.of(context)
                          .pushReplacementNamed('/setup-username');
                    } else {
                      Navigator.of(context).pushReplacementNamed('/');
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
