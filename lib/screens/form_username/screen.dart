import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_routes.dart';
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
    BackButtonInterceptor.add(myInterceptor, zIndex: 2, name: 'username');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    BackButtonInterceptor.removeByName('username');
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushNamed(
      AppRoutes.home,
    );
    return true;
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
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.username),
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
            Card.filled(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.usernameUpdateWarning,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ),
            ),
            FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final username = _usernameController.text.trim();
                  // If the username is the same as the current one, navigate back to the account screen
                  if (username == user?.username) {
                    Navigator.of(context).pushNamed(
                      AppRoutes.profile,
                    );
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
                      Navigator.of(context).pushNamed(
                        AppRoutes.profile,
                      );
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
