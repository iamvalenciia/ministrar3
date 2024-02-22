import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministrar3/riverpod/calculate_distance/calculate_distance_provider.dart';
import 'package:ministrar3/riverpod/help_requests_provider/help_requests_provider.dart';
import 'dart:developer' as developer;

class HelpRequests extends ConsumerWidget {
  const HelpRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helpRequests = ref.watch(getHelpRequestsProvider);
    List<AsyncValue<double>> distances = [];

    developer.log('Help requests before expanded: ${helpRequests.toString()}');

    return Expanded(
      child: helpRequests.when(
        data: (data) {
          developer.log('Help requests (DATA) after expanded: $data');
          distances = data
              .map((request) => ref.watch(streamDistanceProvider(request)))
              .toList();

          developer.log('Distances: $distances');

          return PageView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: Text(data[index].username.toString()),
                  subtitle: distances[index].when(
                    data: (distance) =>
                        // display just 1 decimal place
                        Text('Distance: ${(distance).toStringAsFixed(1)} m'),
                    loading: () => const Text('Calculating distance...'),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                  trailing: Text(data[index].category.toString()),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: Text("Loading...")),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}
