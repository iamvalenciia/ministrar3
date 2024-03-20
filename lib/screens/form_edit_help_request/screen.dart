import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:provider/provider.dart';

const Map<String, String> list = {
  'food': 'Food',
  'medicine': 'Medicine',
  'domestic_violence': 'Domestic Violence',
};

class EditHelpRequest extends StatefulWidget {
  @override
  _EditHelpRequestState createState() => _EditHelpRequestState();
}

class _EditHelpRequestState extends State<EditHelpRequest> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    final myHelpRequestNotifier =
        context.read<MyHelpRequestNotifier>().myHelpRequest;
    _contentController =
        TextEditingController(text: myHelpRequestNotifier?.content ?? '');
    dropdownValue = myHelpRequestNotifier?.category ?? list.keys.first;
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Form(
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
                dropdownMenuEntries: list.entries
                    .map<DropdownMenuEntry<String>>(
                        (MapEntry<String, String> entry) =>
                            DropdownMenuEntry<String>(
                                value: entry.key, label: entry.value))
                    .toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                maxLength: 240,
                maxLines: 6,
                decoration: const InputDecoration(
                  enabled: true,
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
                  if (_formKey.currentState!.validate()) {
                    final success = await context
                        .read<MyHelpRequestNotifier>()
                        .updateMyHelpRequest(
                            dropdownValue, _contentController.text);

                    if (success) {
                      context.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content: Text('Help request updated successfully!'),
                      ));
                    }
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
