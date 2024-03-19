import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ministrar3/services/google.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;
import 'package:ministrar3/models/user_model/user_model.dart';

class UserNotifier extends ChangeNotifier {
  UserModel? userData;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> loginWithGoogle() async {
    _isLoading = true;
    notifyListeners();
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      developer.log('Fetching from auth table',
          error: userId.toString(), name: "UserModel provider");

      final data = await supabase
          .from('profiles')
          .select('username, full_name, avatar_url')
          .eq('id', userId.toString())
          .single();
      developer.log('Fetching from profiles table',
          error: data.toString(), name: "UserModel provider");

      userData = UserModel.fromJson(data);
    } catch (error) {
      developer.log(
        'An error occurred during Google Sign In',
        error: error,
      );
    }
  }

  Future<int> editUsername(String newUsername) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw 'No user is currently logged in.';
      }

      // Update the username in the database
      await supabase
          .from('profiles')
          .update({'username': newUsername}).eq('id', userId);

      // Update the username in the local user model
      userData = UserModel(
        username: newUsername,
        full_name: userData!.full_name,
        avatar_url: userData!.avatar_url,
      );

      notifyListeners(); // Notify listeners about the update
      return 200;
    } catch (e) {
      // If the error is a PostgrestException, we can get the status code
      if (e is PostgrestException) {
        developer.log('Error updating user. Error code: ${e.code}',
            name: 'Riverpod User', error: e);
        if (e.code != null) {
          return int.tryParse(e.code!) ?? 400;
        }
        return 400;
      } else {
        // If the error is not a PostgrestException, we can log the error
        developer.log('Error updating user xd',
            name: 'Riverpod User', error: e.toString());
        return 500;
      }
    }
  }
}
