import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministrar3/riverpod/login_provider/login_provider.dart';
import 'package:ministrar3/riverpod/user_provider/user_provider.dart';
import 'dart:developer' as developer;

class SigninGoogleButton extends ConsumerStatefulWidget {
  const SigninGoogleButton({Key? key}) : super(key: key);

  @override
  _SigninGoogleButtonState createState() => _SigninGoogleButtonState();
}

class _SigninGoogleButtonState extends ConsumerState<SigninGoogleButton> {
  // Tracking the login state
  AsyncValue<bool>? _loginState;

  @override
  Widget build(BuildContext context) {
    final isLoggingIn = _loginState?.isLoading ?? false;
    final loginError = _loginState?.error;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: ElevatedButton(
        onPressed: isLoggingIn
            ? null
            : () async {
                try {
                  setState(() => _loginState = const AsyncLoading());
                  final isLoginSuccessful =
                      await ref.read(loginWithGoogleProvider.future);
                  setState(() => _loginState = AsyncData(isLoginSuccessful));

                  // Additional logic on successful login
                  if (isLoginSuccessful) {
                    final userProfileNotifier =
                        ref.read(userProfileProvider.notifier);
                    final userProfile = await userProfileNotifier.build();

                    if (userProfile.username == null ||
                        userProfile.username!.isEmpty) {
                      Navigator.of(context)
                          .pushReplacementNamed('/setup-username');
                    } else {
                      Navigator.of(context).pushReplacementNamed('/');
                    }
                  }
                } catch (e, stackTrace) {
                  setState(() => _loginState = AsyncError(e, stackTrace));
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
