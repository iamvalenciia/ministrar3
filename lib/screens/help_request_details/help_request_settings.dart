import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/my_hr_provider.dart';
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
    final MyHelpRequestNotifier myHelpRequestNotifier =
        Provider.of<MyHelpRequestNotifier>(context, listen: false);
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
          icon: const Icon(Icons.settings),
          tooltip: 'Settings for your Help Request',
        );
      },
      menuChildren: <Widget>[
        MenuItemButton(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Edit'),
            ),
            onPressed: () => context.go('/edit-help-request')),
        MenuItemButton(
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Delete'),
          ),
          onPressed: () => showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: AlertDialog(
                  content: const Text(
                      'Are you sure you want to delete your help request?',
                      style: TextStyle(fontSize: 18)),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Yes, I am sure'),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        myHelpRequestNotifier.deleteMyHelpRequest().then(
                          (bool response) {
                            if (response) {
                              myHelpRequestNotifier.clearHelpRequest();
                              context.go('/home');
                              showFlashSuccess(context, 'Help Request Deleted');
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
