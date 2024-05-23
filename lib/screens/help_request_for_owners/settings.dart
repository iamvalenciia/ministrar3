import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/my_hr_provider.dart';
import '../../provider/people_helping_provider.dart';
import '../../utility_functions.dart';

class HelpRequestSettings extends StatefulWidget {
  const HelpRequestSettings({super.key, required this.helpRequestId});
  final String helpRequestId;

  @override
  State<HelpRequestSettings> createState() => _HelpRequestSettingsState();
}

class _HelpRequestSettingsState extends State<HelpRequestSettings> {
  @override
  Widget build(BuildContext context) {
    final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
    final peopleHelpingNotifier = context.read<PeopleHelpingNotifier>();
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Icon(Icons.settings,
              color: Theme.of(context).colorScheme.primary),
          tooltip: AppLocalizations.of(context)!.ownersSettings,
        );
      },
      menuChildren: <Widget>[
        MenuItemButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context)!.ownerEdit),
            ),
            onPressed: () => context.go('/help-request-form')),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)!.ownerDelete),
          ),
          onPressed: () => showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: AlertDialog(
                  content: Text(AppLocalizations.of(context)!.ownerAreYouSure,
                      style: const TextStyle(fontSize: 18)),
                  actions: <Widget>[
                    TextButton(
                      child: Text(AppLocalizations.of(context)!.ownerYesImSure),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        myHelpRequestNotifier.deleteMyHelpRequest().then(
                          (bool response) {
                            if (response) {
                              myHelpRequestNotifier.clearHelpRequest();
                              peopleHelpingNotifier.clearPeopleHelping();
                              context.go('/');
                              showFlashSuccess(
                                  context,
                                  AppLocalizations.of(context)!
                                      .ownerHelpRequestDeleted);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
