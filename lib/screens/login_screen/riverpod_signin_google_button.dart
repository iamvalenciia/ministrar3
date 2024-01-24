import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:ministrar3/screens/username_screen/username_screen.dart';
import 'package:ministrar3/providers/user_provider/user_provider.dart';
import 'dart:developer' as developer;

class SigninGoogleButton extends ConsumerWidget {
  const SigninGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: ElevatedButton(
        onPressed: () async {
          ref.read(userNotifierProvider.notifier);
          // final user = supabase.auth.currentUser;
          // if (user == null) {
          //   developer.log(
          //     'User not Exist',
          //     name: 'Google Sign In',
          //   );
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const CreateAccount()),
          //   );
          // } else {
          //   developer.log(
          //     'User signed in successfully $user',
          //     name: 'Google Sign In',
          //   );
          //   Navigator.of(context).pushReplacementNamed('/');
          // }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/app_images/google_logo.png',
                height: 20,
              ),
              const SizedBox(width: 12),
              const Text('Sign In with Google'),
            ],
          ),
        ),
      ),
    );
  }
}
