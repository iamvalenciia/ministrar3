import 'dart:convert';

import 'package:ministrar3/instances/supabase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/user_model/user_model.dart';
import 'dart:developer' as developer;

// Necessary for code-generation to work
part 'user_signin_provider.g.dart';

/// This will create a provider named `userProvider`
/// which will cache the result of this function.
@riverpod
Future<User> user(UserRef ref) async {
  final userId = supabase.auth.currentUser!.id;
  final response =
      await supabase.from('profiles').select().eq('id', userId).single();
  developer.log('Riverpod Fetching user reponse data',
      name: 'Riverpod User', error: jsonEncode(response));
  return User.fromJson(response);
}
