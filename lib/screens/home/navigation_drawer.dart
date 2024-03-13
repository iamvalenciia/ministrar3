import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:ministrar3/services/google.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:provider/provider.dart';

class CustomeNavigationDrawer extends StatelessWidget {
  const CustomeNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userExist = supabase.auth.currentUser?.id != null;
    final helpRequestsNotifier = context.watch<HelpRequestsNotifier>();
    final myHelpRequestNotifier = context.watch<MyHelpRequestNotifier>();
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
          onTap: () async {
            final GoogleSignIn googleSignIn =
                await GoogleProvider.getGoogleSignIn();
            await supabase.auth.signOut();
            await googleSignIn.signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You have successfully signed out'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 5,
              ),
            );
            Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed('/login');
            await helpRequestsNotifier.fetchHelpRequests();
            myHelpRequestNotifier.clearHelpRequest();
          },
        ),
      ],
    );
  }
}
