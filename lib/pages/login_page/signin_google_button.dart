import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ministrar3/instances/google_sign_in.dart';
import 'package:ministrar3/instances/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class SigninGoogleButton extends StatefulWidget {
  const SigninGoogleButton({super.key});

  @override
  State<SigninGoogleButton> createState() => _SigninGoogleButtonState();
}

class _SigninGoogleButtonState extends State<SigninGoogleButton> {
  Future<void> _signInWithGoogle() async {
    setState(() {
      // _isLoading = true;
    });

    try {
      final GoogleSignIn googleSignIn =
          await GoogleSignInProvider.getGoogleSignIn();

      final googleUser = await googleSignIn.signIn();

      // Check if the user cancelled the sign-in
      if (googleUser == null) {
        // _isLoading = false;
        developer.log(
          'User cancelled Google Sign In',
          name: 'Google Sign In',
        );
        return;
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      developer.log(
        'response',
        name: 'Google Sign In',
        error: jsonEncode(response.user),
      );

      if (response.user?.userMetadata != null) {
        final userId = supabase.auth.currentUser!.id;
        final data =
            await supabase.from('profiles').select().eq('id', userId).single();
        if (mounted) {
          if (data['username'] == null) {
            Navigator.of(context).pushReplacementNamed('/setup_username');
          } else {
            Navigator.of(context).pushReplacementNamed('/account');
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Successfully signed in with Google'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          Navigator.of(context).pushReplacementNamed('/');
        }
      }
      // developer.log(
      //   'User signed in successfully $response',
      //   name: 'Google Sign In',
      //   level: 2,
      // );
    } catch (error) {
      developer.log(
        'An error occurred during Google Sign In',
        error: error,
      );
    } finally {
      if (mounted) {
        setState(() {
          // _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: ElevatedButton(
        onPressed: _signInWithGoogle,
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
