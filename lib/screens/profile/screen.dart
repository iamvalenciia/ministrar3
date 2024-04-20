import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/activity_model/activity_model.dart';
import '../../models/user_model/user_model.dart';
import '../../provider/activity_provider.dart';
import '../../provider/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isExpanded = false; // State variable to track expansion

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.read<UserNotifier>().user;
    final peopleHelped = context.read<UserNotifier>().peopleHelped;

    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                radius: 30,
                backgroundImage:
                    CachedNetworkImageProvider('${user?.avatar_url}')),
            title: Row(
              children: [
                Flexible(
                  child: Selector<UserNotifier, String>(
                    selector: (_, notifier) =>
                        notifier.user?.username ?? 'error',
                    builder: (_, username, __) => Text(
                      '@$username',
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: const Icon(Icons.more_vert),
                      tooltip: 'Settings for your Help Request',
                    );
                  },
                  menuChildren: <Widget>[
                    MenuItemButton(
                        // leadingIcon: const Icon(Icons.edit),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Edit Username',
                              style: TextStyle(fontSize: 16)),
                        ),
                        onPressed: () => context.go('/username-form')),
                  ],
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Icon(Icons.volunteer_activism,
                    color: Theme.of(context).colorScheme.primary),
                Text(' $peopleHelped ', style: const TextStyle(fontSize: 16)),
                Text(peopleHelped == 1 ? 'Person Helped' : 'People Helped',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Icon(Icons.history, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              const Text('Recent Activities',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          Selector<ActivityNotifier, List<Activity>>(
            selector: (_, notifier) => notifier.activities ?? [],
            builder: (_, activity, __) {
              if (activity.isEmpty) {
                return const Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'There are no activities to show yet',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: activity.length,
                      itemBuilder: (context, index) {
                        final currentActivity = activity[index];
                        if (currentActivity.status == null &&
                            currentActivity.activity_type == 'help') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Is trying to help to ${currentActivity.help_request_owner_username}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        } else if (currentActivity.status ??
                            true && currentActivity.activity_type == 'help') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Helped to @${currentActivity.help_request_owner_username} ${timeago.format(currentActivity.status_updated_at!)}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        } else if (currentActivity.status == false &&
                            currentActivity.activity_type == 'help') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Failed to help to @${currentActivity.help_request_owner_username} ${timeago.format(currentActivity.status_updated_at!)}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        } else if (currentActivity.activity_type == 'post') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Created a Help Request ${timeago.format(currentActivity.inserted_at!)}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Activity type not recognized status: ${currentActivity.status}, type: ${currentActivity.activity_type}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
