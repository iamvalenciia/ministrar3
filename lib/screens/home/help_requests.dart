import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministrar3/riverpod/calculate_distance/calculate_distance_provider.dart';
import 'package:ministrar3/riverpod/help_requests_provider/help_requests_provider.dart';

class HelpRequests extends ConsumerWidget {
  const HelpRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helpRequests = ref.watch(getHelpRequestsProvider);

    return helpRequests.when(
      data: (data) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final distanceStream = ref.watch(streamDistanceProvider);
            // Correct access

            return Container(
              width: 300,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: Text(data[index].username.toString()),
                  subtitle: distanceStream.when(
                    data: (distance) =>
                        Text('Distance: ${distance.toStringAsFixed(1)} m'),
                    loading: () => const Text('Calculating distance...'),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                  trailing: Text(data[index].category.toString()),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: Text("Loading...")),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
