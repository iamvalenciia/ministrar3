import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ministrar3/provider/user_provider.dart';
import 'package:ministrar3/services/google.dart';
import 'dart:developer' as developer;

import 'package:ministrar3/services/supabase.dart';
import 'package:provider/provider.dart';

class UsernameFormScreen extends StatefulWidget {
  @override
  _UsernameFormScreenState createState() => _UsernameFormScreenState();
}

class _UsernameFormScreenState extends State<UsernameFormScreen> {
  late final TextEditingController _usernameController;
  final _formKey = GlobalKey<FormState>(); // Add this line

  @override
  void initState() {
    super.initState();
    final user = context.read<UserNotifier>().userModel;
    _usernameController =
        TextEditingController(text: user?.username ?? "Empty error code");
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvier = context.read<UserNotifier>();
    final user = context.watch<UserNotifier>().userModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup your Username'),
        leading: IconButton(
          onPressed: () async {
            if (user?.username != null) {
              Navigator.of(context).pushReplacementNamed('/account');
            } else {
              Navigator.of(context).pushReplacementNamed('/login');
              final GoogleSignIn googleSignIn =
                  await GoogleProvider.getGoogleSignIn();
              await supabase.auth.signOut();
              await googleSignIn.signOut();
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  if (value.length < 3) {
                    return "Username must be at least 3 characters long";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final username = _usernameController.text.trim();
                    // If the username is the same as the current one, navigate back to the account screen
                    if (username == user?.username) {
                      Navigator.of(context).pushReplacementNamed('/account');
                      return;
                    }
                    try {
                      final int code = await userProvier.editUsername(username);

                      switch (code) {
                        case 200: // OK
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Username updated successfully.')),
                          );
                          // navigate home
                          Navigator.of(context)
                              .pushReplacementNamed('/account');
                          break;
                        case 23505: // Duplicate key value
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('This username is already taken.')),
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
                                content: Text(
                                    'Server error. Please try again later.')),
                          );
                          break;
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'An unexpected error occurred. Please try again Later.')),
                      );
                      developer.log('Error updating username', error: e);
                    }
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
