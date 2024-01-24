import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ministrar3/services/google.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/user_model/user_model.dart' as user_model;
import '../../../models/user_id/user_id.dart';
import 'dart:developer' as developer;

// Necessary for code-generation to work
part 'user_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  UserNotifier() : super();

  Future<String> build() async {
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

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      // await supabase.auth.admin.deleteUser(response.user!.id);

      // developer.log(
      //   'final response = await supabase.auth.signInWithIdToken',
      //   name: 'Google Sign In',
      //   error: jsonEncode(response),
      // );

      return response.user?.id ?? 'user_not_found';
    } catch (error) {
      developer.log(
        'An error occurred during Google Sign In',
        error: error,
      );
      return 'user_not_found';
    }
  }

  Future<bool> userExist() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final response =
          await supabase.from('profiles').select().eq('id', userId).single();
      developer.log('User Exist?', name: 'Check user exist', error: response);
      return response['id'] == userId;
    } catch (e) {
      developer.log('User Exist?', name: 'Check user exist', error: false);
      return false;
    }
  }

  Future<user_model.User> fetchUser(userId) async {
    try {
      final response =
          await supabase.from('profiles').select().eq('id', userId).single();
      developer.log('Riverpod Fetching user response data',
          name: 'Riverpod User', error: jsonEncode(response));
      return user_model.User.fromJson(response);
    } catch (e) {
      developer.log('Error fetching user', name: 'Riverpod User', error: e);
      return user_model.User(
          id: 'error',
          full_name: 'error',
          username: 'error',
          avatar_url: 'error');
    }
  }

  Future<void> updateUser(user_model.User updatedUser) async {
    try {
      // final userId = supabase.auth.currentUser!.id;
      final response = await supabase
          .from('profiles')
          .update(updatedUser.toJson())
          .eq('id', updatedUser.id)
          .select();

      developer.log('Riverpod Updating user response data',
          name: 'Riverpod User', error: response.toString());
    } catch (e) {
      developer.log('Error updating user', name: 'Riverpod User', error: e);
      developer.log('updatedUser variable',
          name: 'Riverpod User', error: updatedUser.full_name);
    }
  }
}
