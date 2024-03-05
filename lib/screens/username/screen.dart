import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ministrar3/provider/user_provider.dart';
import 'package:ministrar3/services/google.dart';
import 'dart:developer' as developer;

import 'package:ministrar3/services/supabase.dart';
import 'package:provider/provider.dart';

class UsernameScreen extends StatefulWidget {
  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProvider>().userModel;
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
    final userProvier = context.read<UserProvider>();
    final user = context.watch<UserProvider>().userModel;
    developer.log('USERNAME SCREEN',
        error: userProvier.userModel, name: "USER PROVIDER");

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
              onPressed: () async {
                final username = _usernameController.text.trim();
                if (username.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a username.')),
                  );
                  return;
                }

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
                            content: Text('Username updated successfully.')),
                      );
                      // navigate home
                      Navigator.of(context).pushReplacementNamed('/account');
                      break;
                    case 23505: // Duplicate key value
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('This username is already taken.')),
                      );
                      break;
                    case 400: // Client error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'There was an issue with the request. Please try again.')),
                      );
                      break;
                    case 23514: // Client error

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Username must be at least 3 characters long")),
                      );
                      break;
                    default: // Server error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Server error. Please try again later.')),
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
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
