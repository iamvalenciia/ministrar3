import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ministrar3/services/google.dart';
import 'package:ministrar3/services/supabase.dart';

class CustomeNavigationDrawer extends StatefulWidget {
  const CustomeNavigationDrawer({super.key});

  @override
  State<CustomeNavigationDrawer> createState() =>
      _CustomeNavigationDrawerState();
}

class _CustomeNavigationDrawerState extends State<CustomeNavigationDrawer> {
  Future<void> _signOut() async {
    final GoogleSignIn googleSignIn = await GoogleProvider.getGoogleSignIn();
    await supabase.auth.signOut();
    await googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final userExist = supabase.auth.currentUser?.id != null;
    return NavigationDrawer(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: const Text('Drawer Header'),
        ),
        ListTile(
          enabled: userExist,
          selectedColor: Theme.of(context).colorScheme.primary,
          title: const Text('Profile'),
          leading: const Icon(Icons.account_circle),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed('/account');
          },
        ),
        ListTile(
          enabled: userExist,
          title: const Text('Logout'),
          leading: const Icon(Icons.logout),
          onTap: () {
            _signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                content: const Text('You have successfully signed out'),
              ),
            );
            Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
      ],
    );
  }
}
