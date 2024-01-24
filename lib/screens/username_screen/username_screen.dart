import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministrar3/models/user_model/user_model.dart';
import 'package:ministrar3/providers/user_provider/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  const UsernameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _fullNameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(userNotifierProvider.notifier);
    final userFuture =
        ref.read(userNotifierProvider.notifier).fetchUser(userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<User>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(
                'Oops, something unexpected happened: ${snapshot.error}');
          } else {
            User user = snapshot.data!;
            return Column(
              children: [
                // if (user.avatar_url != null && user.avatar_url!.isNotEmpty)
                //   CachedNetworkImage(
                //     imageUrl: user.avatar_url!,
                //     placeholder: (context, url) =>
                //         const CircularProgressIndicator(),
                //     errorWidget: (context, url, error) =>
                //         const Icon(Icons.error),
                //   )
                // else
                const Icon(
                  Icons.account_circle,
                  size: 40,
                ),
                Text('Hello ${user.full_name}, please setup your username'),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                ElevatedButton(
                  onPressed: () {
                    User updateUser = User(
                      id: user.id,
                      username: _usernameController.text,
                      full_name: _fullNameController.text,
                      updated_at: DateTime.now(),
                      // Add other fields as necessary
                    );
                    ref
                        .read(userNotifierProvider.notifier)
                        .updateUser(updateUser);
                  },
                  child: const Text('Update'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
