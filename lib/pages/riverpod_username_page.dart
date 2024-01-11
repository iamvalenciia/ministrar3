import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministrar3/models/user_model/user_model.dart';
import 'package:ministrar3/providers/user_signin_provider/user_signin_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// We subclassed "ConsumerWidget" instead of "StatelessWidget".
/// This is equivalent to making a "StatelessWidget" and retuning "Consumer".
class SetupUsername extends ConsumerWidget {
  const SetupUsername({super.key});

  @override
  // Notice how "build" now receives an extra parameter: "ref"
  Widget build(BuildContext context, WidgetRef ref) {
    // We can use "ref.watch" inside our widget like we did using "Consumer"
    final AsyncValue<User> user = ref.watch(userProvider);

    // The rendering logic stays the same
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        child: user.when(
          data: (user) => Row(
            children: [
              CachedNetworkImage(
                imageUrl: user.avatar_url ?? '',
                placeholder: (context, url) => const Icon(
                  Icons.account_circle,
                  size: 40,
                ),
              ),
              Text('Hello ${user.id}'),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) =>
              Text('Oops, something unexpected happened'),
        ),
      ),
    );
  }
}
