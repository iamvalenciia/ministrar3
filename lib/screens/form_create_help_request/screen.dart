import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/activity_provider.dart';
import '../../provider/my_hr_provider.dart';
import '../../utility_functions.dart';

const Map<String, String> list = {
  'food': 'Food',
  'medicine': 'Medicine',
  'domestic_violence': 'Domestic Violence',
};

class HelpRequestFormScreen extends StatefulWidget {
  const HelpRequestFormScreen({super.key});

  @override
  _HelpRequestFormScreenState createState() => _HelpRequestFormScreenState();
}

class _HelpRequestFormScreenState extends State<HelpRequestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _contentController;
  String dropdownValue = list.keys.first;
  bool _useLocation = false;
  late List<DropdownMenuEntry<String>> dropdownMenuEntries;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    dropdownMenuEntries = list.entries
        .map<DropdownMenuEntry<String>>((MapEntry<String, String> entry) =>
            DropdownMenuEntry<String>(value: entry.key, label: entry.value))
        .toList();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
    final activitiesNotifier = context.read<ActivityNotifier>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            DropdownMenu<String>(
              initialSelection: list.keys.first,
              onSelected: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries: dropdownMenuEntries,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _contentController,
              maxLength: 240,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Type your help request here ...',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field can't be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text(
                  'Create this help request using my current location'),
              value: _useLocation,
              onChanged: (bool? value) {
                setState(() {
                  _useLocation = value!;
                });
              },
              controlAffinity: ListTileControlAffinity
                  .leading, //  places the control on the start or leading side
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _useLocation
                  ? () async {
                      try {
                        if (_formKey.currentState!.validate()) {
                          final success =
                              await myHelpRequestNotifier.createMyHelpRequest(
                                  dropdownValue, _contentController.text);

                          if (success) {
                            activitiesNotifier.createLocalActivity();
                            // DON'T use BuildContext across asynchronous gaps.
                            if (!context.mounted) {
                              return;
                            }
                            context.go('/home');
                            showFlashSuccess(context, 'Help request created');
                          }
                        }
                      } catch (e) {
                        // DON'T use BuildContext across asynchronous gaps.
                        if (!context.mounted) {
                          return;
                        }
                        showFlashError(context, 'Error - Create HR button: $e');
                      }
                    }
                  : null,
              child: const Text('Create Help Request'),
            ),
          ],
        ),
      ),
    );
  }
}












// this will be the form to create HR
// this going to use a (function) to create the hr and the activity posts:
// id, owner_id, created_at
// @username created a help request at Mar-07-2024


// When a user press Help button create a activity help
// id, post_id, helper_id, status, created_at, helped_at
// The status = Null
// the owner can change the status to True or False, by default is null
// [And if the owner dind't change the status in 24 hours the status:]
// [Flutter will calculate if have been 24 hours and will update the status to False]

// When the owner change the status of the activit help to True:
// the receive_help_at is updated in Supabase and also in Fluter
// so everybody can see how much time have before the post ends

// In Fluter
// take the receive_help_at to calculated if has been 24 hours since the help was requested
// [if have been 24 hourse remove al the acivity help with status = null / False]
// [and also remove the help request]

// So in the profile just fetch the activity help with status = True
// @username1 helped @username2 at Mar-07-2024


// POLICY
// Owners can creates posts, and activity posts
// Owners can update their receive_help_at and the status/helped_at of the activity help
// Users can created activity help

// @username1 helped @username2 at Mar-07-2024

