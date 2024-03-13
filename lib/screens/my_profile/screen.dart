import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ministrar3/provider/activity_provider.dart';
import 'package:provider/provider.dart';
import 'package:ministrar3/provider/user_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the notifier
    final userProvider = context.watch<UserNotifier>();
    final activityProvider = context.watch<ActivityNotifier>();
    final userModel = userProvider.userModel;
    final activityModel = activityProvider.activityPosts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        CachedNetworkImageProvider('${userModel?.avatar_url}'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('@${userModel?.username}',
                                style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis),
                            SizedBox(height: 10),
                            // elevate button to edit username with icon
                            ElevatedButton.icon(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacementNamed('/username-form'),
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
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    title: Text(
                        "Created a help request ${activityModel != null ? timeago.format(activityModel[index].created_at) : 'Unknown'}"),
                  ));
                },
                childCount: activityModel?.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
