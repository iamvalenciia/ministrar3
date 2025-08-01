import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: ListTile(
        leading: const Icon(Icons.login),
        title: Row(
          children: [
            Expanded(
              // the expanded widget is used to make the text fill the available space
              // so this help to avoid horizontal overflow
              child:
                  Text(AppLocalizations.of(context)!.homePleaseLoginToContinue),
            ),
            const SizedBox(width: 8),
            TextButton(
                child: Text(AppLocalizations.of(context)!.homeLogin),
                // add logic to open up screen to continue with google, xd
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
