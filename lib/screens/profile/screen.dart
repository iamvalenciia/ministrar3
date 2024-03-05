import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ministrar3/provider/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the notifier
    final userProvider = context.watch<UserProvider>();
    final userModel = userProvider.userModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  CachedNetworkImageProvider('${userModel?.avatar_url}'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            .pushReplacementNamed('/setup-username'),
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Username'),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
