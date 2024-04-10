import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/my_hr_provider.dart';
import '../../utility_functions.dart';

const Map<String, String> list = {
  'food': 'Food',
  'medicine': 'Medicine',
  'domestic_violence': 'Domestic Violence',
};

class EditHelpRequest extends StatefulWidget {
  const EditHelpRequest({super.key});

  @override
  _EditHelpRequestState createState() => _EditHelpRequestState();
}

class _EditHelpRequestState extends State<EditHelpRequest> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;
  late String dropdownValue;
  late List<DropdownMenuEntry<String>> dropdownMenuEntries;

  @override
  void initState() {
    super.initState();
    final myHelpRequestNotifier =
        context.read<MyHelpRequestNotifier>().myHelpRequest;
    _contentController =
        TextEditingController(text: myHelpRequestNotifier?.content ?? '');
    dropdownValue = myHelpRequestNotifier?.category ?? list.keys.first;
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
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            DropdownMenu<String>(
              initialSelection: dropdownValue,
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
            ElevatedButton(
              onPressed: () async {
                try {
                  if (_formKey.currentState!.validate()) {
                    final success = await context
                        .read<MyHelpRequestNotifier>()
                        .updateMyHelpRequest(
                            dropdownValue, _contentController.text);
                    // DON'T use BuildContext across asynchronous gaps.
                    if (!context.mounted) {
                      return;
                    }
                    if (success) {
                      context.go('/');
                      showFlashSuccess(context, 'Help Request Updated');
                    }
                  }
                } catch (e) {
                  showFlashError(context, 'Error - Update HR Button: $e');
                }
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
