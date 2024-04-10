import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/my_hr_provider.dart';
import '../../provider/user_provider.dart';

class MyHelpRequest extends StatelessWidget {
  const MyHelpRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final userExist = context.select((UserNotifier un) => un.isUserLoggedIn);
    final username = context.select((UserNotifier un) => un.user?.username);
    final myHelpRequest =
        context.select((MyHelpRequestNotifier mhrn) => mhrn.myHelpRequest);
    developer.log('${myHelpRequest?.help_request_owner_id}',
        name: 'myHelpRequest MyHelpRequest MyHelpRequest');
    developer.log('${myHelpRequest?.avatar_url}',
        name: 'myHelpRequest MyHelpRequest MyHelpRequest');
    developer.log('$myHelpRequest',
        name: 'myHelpRequest MyHelpRequest MyHelpRequest');

    if (myHelpRequest != null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Card(
            child: SizedBox(
              width: 300, // Set a finite width here
              child: ListTile(
                leading: const Icon(Icons.account_circle),
                title: Text(
                  username.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Selector<MyHelpRequestNotifier, double>(
                  selector: (_, notifier) => notifier.distance ?? 1.1,
                  builder: (_, distance, __) {
                    return Text(
                      distance != 1.1
                          ? '${distance.toInt()} meters'
                          : 'Calculating ...',
                    );
                  },
                ),
                trailing: Text(myHelpRequest.category.toString()),
                onTap: () => context.go(
                    '/help-request-for-owners/${myHelpRequest.help_request_owner_id}'),
              ),
            ),
          );
        },
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 50),
        child: ElevatedButton(
          onPressed: userExist ? () => context.go('/help-request-form') : null,
          child: const Row(
            children: [
              Icon(Icons.post_add),
              SizedBox(width: 10),
              Text('Create a Help Request'),
            ],
          ),
        ),
      );
    }
  }
}
