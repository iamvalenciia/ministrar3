import 'package:flutter/material.dart';

class AppDescription extends StatefulWidget {
  const AppDescription({super.key});

  @override
  State<AppDescription> createState() => _AppDescriptionState();
}

class _AppDescriptionState extends State<AppDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.displayLarge,
          children: <TextSpan>[
            TextSpan(
              text: 'Help',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: ' &',
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: ' Be Helped:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const TextSpan(text: " It's That Simple"),
          ],
        ),
      ),
    );
  }
}
