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

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  width: 100, // Adjust width as needed
                  height: 100, // Adjust height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider('${user?.avatar_url}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Selector<UserNotifier, String>(
                              selector: (_, notifier) =>
                                  notifier.user?.username ?? 'error',
                              builder: (_, username, __) => Text(
                                '@$username',
                                overflow: TextOverflow.fade,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          MenuAnchor(
                            builder: (BuildContext context,
                                MenuController controller, Widget? child) {
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
                                        style: TextStyle()),
                                  ),
                                  onPressed: () =>
                                      context.go('/username-form')),
                            ],
                          ),
                        ],
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ministered persons'),
                          Row(
                            children: [
                              Icon(Icons.people),
                              const SizedBox(width: 10),
                              Text('0'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Add some spacing between the text and the divider
          Selector<ActivityNotifier, List<Activity>>(
            selector: (_, notifier) => notifier.activityPosts ?? [],
            builder: (_, activityModel, __) => Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: activityModel
                      .expand((activity) => [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Created a help request ${timeago.format(activity.inserted_at!)}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey)),
                            ),
                            const Divider(),
                          ])
                      .toList()
                    ..removeLast(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
