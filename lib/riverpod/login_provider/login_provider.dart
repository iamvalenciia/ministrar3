import 'package:google_sign_in/google_sign_in.dart';
import 'package:ministrar3/services/google.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

// Necessary for code-generation to work
part 'login_provider.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<bool> loginWithGoogle(LoginWithGoogleRef ref) async {
  try {
    final GoogleSignIn googleSignIn = await GoogleProvider.getGoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    final googleAuth = await googleUser?.authentication;
    final accessToken = googleAuth?.accessToken;
    final idToken = googleAuth?.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    // Check if the user is successfully logged in
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      // Login successful
      return true;
    } else {
      // Login unsuccessful
      return false;
    }
  } catch (error) {
    developer.log('An error occurred during Google Sign In', error: error);
    return false;
  }
}
