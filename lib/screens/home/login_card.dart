import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.login),
        title: Row(
          children: [
            const Expanded(
              // the expanded widget is used to make the text fill the available space
              // so this help to avoid horizontal overflow
              child: Text('Please login to interact with the app'),
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Text('Login'),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/login'),
            ),
          ],
        ),
      ),
    );
  }
}
