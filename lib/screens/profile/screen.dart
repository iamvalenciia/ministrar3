import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministrar3/riverpod/user_provider/user_provider.dart';
import 'package:ministrar3/models/user_model/user_model.dart';

// Consumes the shared state and rebuild when it changes
class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<UserModel> user = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: user.when(
        data: (UserModel value) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    CachedNetworkImageProvider('${value.avatar_url}'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('@${value.username}',
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            const Center(child: Text('Oops, something unexpected happened')),
      ),
    );
  }
}
