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
          Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image:
                            CachedNetworkImageProvider('${user?.avatar_url}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Selector<UserNotifier, String>(
                    selector: (_, notifier) =>
                        notifier.user?.username ?? 'error',
                    builder: (_, username, __) => Text(
                      '@$username',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
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
                            child: Text('Edit Username', style: TextStyle()),
                          ),
                          onPressed: () => context.go('/username-form')),
                    ],
                  )
                ],
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.people,
              ),
              const SizedBox(width: 10),
              const Text(
                'This user has helped',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Card.filled(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const Text(
                'people',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          // Add some spacing between the text and the divider
          Selector<ActivityNotifier, List<Activity>>(
            selector: (_, notifier) => notifier.activityPosts ?? [],
            builder: (_, activityModel, __) => ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) => setState(() {
                this.isExpanded = isExpanded; // Update the state variable
              }),
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) => const ListTile(
                    title: Text('Last User Activities'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: activityModel
                          .map((activity) => _ActivityCard(activity: activity))
                          .toList(),
                    ),
                  ),
                  isExpanded: isExpanded, // Initially expand the panel
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------/
//  widget used in the ProfileScreen widget /
//------------------------------------------/
class _ActivityCard extends StatelessWidget {
  const _ActivityCard({this.activity});
  final Activity? activity;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Text(
            "Created a help request ${activity != null ? timeago.format(activity!.inserted_at) : 'Unknown'}",
            style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}
