import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/activity_provider.dart';
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
    final bool wasLastActivityHelpTrue =
        context.read<ActivityNotifier>().wasLastActivityHelp();
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
                subtitle: Selector<MyHelpRequestNotifier,
                    ({double distance, bool unit})>(
                  selector: (_, notifier) => (
                    distance: notifier.distance ?? 1.1,
                    unit: notifier.isDistanceInKilometers
                  ),
                  builder: (_, data, __) {
                    final distance = data.distance;
                    final isDistanceInKilometers = data.unit;
                    final unit = isDistanceInKilometers ? 'km' : 'mi';
                    return Text(
                      distance != 1.1
                          ? '${distance.toStringAsFixed(1)} $unit'
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
    } else if (wasLastActivityHelpTrue) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 50),
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
    } else if (!wasLastActivityHelpTrue) {
      return Center(
        child: Card.filled(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'To make another help request, please help someone else first',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.volunteer_activism,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              )),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
