import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model/user_model.dart';
import '../services/google.dart';
import '../services/supabase.dart';

class UserNotifier extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  int _peopleHelped = 0;
  bool _isUserLoggedIn = false;

  bool get isLoading => _isLoading;
  int get peopleHelped => _peopleHelped;
  UserModel? get user => _user;
  bool get isUserLoggedIn => _isUserLoggedIn;

  Future<void> loginWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    try {
      final GoogleSignIn googleSignIn = await GoogleProvider.getGoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;
      final accessToken = googleAuth?.accessToken;
      final idToken = googleAuth?.idToken ?? '';

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (error) {
      developer.log('An error occurred during Google Sign In', error: error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      developer.log('Fetching from auth table',
          error: userId.toString(), name: 'UserModel provider');

      final data = await supabase
          .from('profiles')
          .select('username, full_name, avatar_url')
          .eq('id', userId.toString())
          .single();
      developer.log('Fetching from profiles table',
          error: data.toString(), name: 'UserModel provider');

      fetchPeopleHelped();

      _user = UserModel.fromJson(data);
    } catch (error) {
      developer.log(
        'An error occurred during Google Sign In',
        error: error,
      );
    }
  }

  Future<void> fetchPeopleHelped() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      final response =
          await supabase.rpc('get_total_people_helped_count', params: {
        'query_user_id': userId,
      });

      _peopleHelped = response as int;
    } catch (error) {
      developer.log('An error occurred during Google Sign In', error: error);
    }
  }

  Future<Map<String, dynamic>> editUsername(String newUsername) async {
    try {
      final userId = supabase.auth.currentUser?.id;

      // Update the username in the database
      await supabase
          .from('profiles')
          .update({'username': newUsername}).eq('id', userId!);

      // Update the username in the local user model
      _user?.username = newUsername;

      notifyListeners(); // Notify listeners about the update
      return {'code': 200, 'message': 'Username updated successfully.'};
    } catch (e) {
      // If the error is a PostgrestException, we can get the status code
      if (e is PostgrestException) {
        developer.log('Error updating user. Error code: ${e.code}',
            name: 'Riverpod User', error: e);
        if (e.code != null) {
          final int code = int.tryParse(e.code!) ?? 400;
          String message;
          switch (code) {
            case 23505:
              message = 'This username is already taken';
            case 400:
              message = 'There was an issue with the request. Please try again';
            default:
              message = 'Server error. Please try again later';
              break;
          }
          return {'code': code, 'message': message};
        }
        return {
          'code': 400,
          'message': 'There was an issue with the request. Please try again'
        };
      } else {
        // If the error is not a PostgrestException, we can log the error
        developer.log('Error updating user xd',
            name: 'Riverpod User', error: e.toString());
        return {
          'code': 500,
          'message': 'An unexpected error occurred. Please try again Later'
        };
      }
    }
  }

  Future<void> logOut() async {
    final googleService = await GoogleProvider.getGoogleSignIn();
    await supabase.auth.signOut();
    googleService.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> deleteMyAccount() async {
    final userId = supabase.auth.currentUser?.id;
    // final googleService = await GoogleProvider.getGoogleSignIn();

    await supabase
        .from('activities')
        .delete()
        .eq('activity_owner_id', userId.toString());
    await supabase
        .from('help_requests')
        .delete()
        .eq('help_request_owner_id', userId.toString());
    await supabase.from('profiles').delete().eq('id', userId.toString());

    _user = null;
    notifyListeners();
  }

  void updateLoginStatus() {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    developer.log('supabase.auth.currentUser?.id: $userId',
        name: 'updateLoginStatus');
    if (userId != null) {
      _isUserLoggedIn = true;
    } else {
      _isUserLoggedIn = false;
    }
    notifyListeners();
  }
}
