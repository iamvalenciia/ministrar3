import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ministrar3/models/activity_model/activity_model.dart';
import 'package:ministrar3/models/user_model/user_model.dart';
import 'package:ministrar3/provider/activity_provider.dart';
import 'package:provider/provider.dart';
import 'package:ministrar3/provider/user_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserNotifier>().userData;
    final activityModel = context.watch<ActivityNotifier>().activityPosts;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      CachedNetworkImageProvider('${userData?.avatar_url}'),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('@${userData?.username}',
                              overflow: TextOverflow.ellipsis),
                          SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () =>
                                context.go('/home/account/username-form'),
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit Username'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: activityModel?.length ?? 0,
              itemBuilder: (context, index) {
                final activity = activityModel?[index];
                return _ActivityCard(activity: activity);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final UserModel? userData;

  const _ProfileHeader({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
              CachedNetworkImageProvider('${userData?.avatar_url}'),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('@${userData?.username}',
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/home/account/username-form'),
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Username'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final Activitie? activity;

  const _ActivityCard({Key? key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
            "Created a help request ${activity != null ? timeago.format(activity!.inserted_at) : 'Unknown'}"),
      ),
    );
  }
}
