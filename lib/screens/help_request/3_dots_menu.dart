import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:provider/provider.dart';

class HelpRequestSettings extends StatefulWidget {
  final helpRequestId;
  const HelpRequestSettings({super.key, required this.helpRequestId});

  @override
  State<HelpRequestSettings> createState() => _HelpRequestSettingsState();
}

class _HelpRequestSettingsState extends State<HelpRequestSettings> {
  @override
  Widget build(BuildContext context) {
    final myHelpRequestNotifier =
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
              // leadingIcon: const Icon(Icons.edit),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Edit', style: TextStyle()),
              ),
              onPressed: () => context.go('/home/edit-help-request')),
          MenuItemButton(
            // leadingIcon: const Icon(Icons.delete),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Delete', style: TextStyle()),
            ),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: AlertDialog(
                    content: const Text(
                        'Are you sure you want to delete your help request?',
                        style: TextStyle(fontSize: 18)),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Yes, I am sure'),
                        onPressed: () async {
                          final response =
                              await myHelpRequestNotifier.deleteMyHelpRequest();
                          if (response) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Help Request Deleted'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              elevation: 5,
                            ));
                            context.go('/home');
                            myHelpRequestNotifier.clearHelpRequest();
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ]);
  }
}
