import 'package:ministrar3/services/supabase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ministrar3/models/user_model.dart';
import 'dart:developer' as developer;
// command to generate the file
// dart run build_runner build
// Necessary for code-generation to work
part 'user_provider.g.dart';

@riverpod
class UserProfile extends _$UserProfile {
  @override
  Future<UserModel> build() async {
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

      return UserModel(
        id: userId.toString(),
        username: data['username'],
        full_name: data['full_name'],
        avatar_url: data['avatar_url'],
      );
    } catch (error) {
      developer.log(
        'An error occurred during Google Sign In',
        error: error,
      );
      return UserModel(
        id: '',
        username: '',
        full_name: '',
        avatar_url: '',
      );
    }
  }

  Future<int> updateUser(String userId, String newUsername) async {
    try {
      //Run the update query
      final response = await supabase
          .from('profiles')
          .update({'username': newUsername}).match({'id': userId}).select();
      UserModel updatedUser = UserModel.fromJson(response[0]);
      state = AsyncData(updatedUser);
      developer.log('state variable', error: state);
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
