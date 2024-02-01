import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministrar3/models/user_model/user_model.dart';
import 'package:ministrar3/providers/user_provider/user_provider.dart';
import 'dart:developer' as developer;

import 'package:ministrar3/services/supabase.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  const UsernameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _updateUsername() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a username.')),
      );
      return;
    }
    try {
      final userId = supabase.auth.currentUser?.id;
      final int code = await ref
          .read(userProfileProvider.notifier)
          .updateUser(userId.toString(), username);

      switch (code) {
        case 200: // OK
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Welcome $username')),
          );
          // navigate home
          Navigator.of(context).pushReplacementNamed('/');
          break;
        case 23505: // Duplicate key value
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This username is already taken.')),
          );
          break;
        case 400: // Client error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'There was an issue with the request. Please try again.')),
          );
          break;
        default: // Server error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Server error. Please try again later.')),
          );
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('An unexpected error occurred. Please try again Later.')),
      );
      developer.log('Error updating username', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup your Username'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUsername,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
