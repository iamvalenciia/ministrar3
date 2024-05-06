import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../../utility_functions.dart';

class UsernameFormScreen extends StatefulWidget {
  const UsernameFormScreen({super.key});

  @override
  _UsernameFormScreenState createState() => _UsernameFormScreenState();
}

class _UsernameFormScreenState extends State<UsernameFormScreen> {
  late final TextEditingController _usernameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final user = context.read<UserNotifier>().user;
    _usernameController = TextEditingController(text: user?.username ?? '');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvier = context.read<UserNotifier>();
    final user = context.read<UserNotifier>().user;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              style: const TextStyle(fontSize: 18),
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!
                      .usernameThisfieldcantBeEmpty;
                }
                if (value.length < 3) {
                  return AppLocalizations.of(context)!
                      .usernameMustBeAtLeast3Characters;
                }
                if (value.contains(' ')) {
                  return AppLocalizations.of(context)!.usernameCanthaveSpaces;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final username = _usernameController.text.trim();
                  // If the username is the same as the current one, navigate back to the account screen
                  if (username == user?.username) {
                    context.go('/account');
                    return;
                  }
                  try {
                    final Map<String, dynamic> result =
                        await userProvier.editUsername(username);
                    // DON'T use BuildContext across asynchronous gaps.
                    if (!context.mounted) {
                      return;
                    }
                    if (result['code'] == 200) {
                      showFlashSuccess(context, '${result['message']}');
                      context.go('/account');
                    } else {
                      showFlashError(context, '${result['message']}');
                    }
                  } catch (e) {
                    showFlashError(context, e.toString());
                  }
                }
              },
              child: Text(AppLocalizations.of(context)!.usernameUpdateButton),
            ),
          ],
        ),
      ),
    );
  }
}
