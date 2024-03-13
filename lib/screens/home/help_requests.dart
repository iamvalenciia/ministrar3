// help_requests.dart
import 'package:flutter/material.dart';
import 'package:ministrar3/models/help_requests_model/help_request_model.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:provider/provider.dart';

class HelpRequestsScreen extends StatelessWidget {
  final void Function(HelpRequestModel) onSelect;

  HelpRequestsScreen({required this.onSelect});
  @override
  Widget build(BuildContext context) {
    // Accessing the notifier
    final helpRequestsNotifier = context.watch<HelpRequestsNotifier>();
    final helpRequests = helpRequestsNotifier.helpRequests;
    final isLoading = helpRequestsNotifier.isLoading;
    final isFirstLoad = helpRequestsNotifier.isFirstLoad;
    final error = helpRequestsNotifier.error;

    if (isLoading && isFirstLoad) {
      // (isFirstLoad) when the app starts, after that user can see the load from pull to refresh
      // in the future we can edit this to show a nice placeholder load
      return const Center(child: CircularProgressIndicator());
    } else if (error != null) {
      return Center(child: Text('Error: $error'));
    } else if (helpRequests != null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: helpRequests.length,
        itemBuilder: (context, index) {
          final request = helpRequests[index];
          // Assuming you have a distance calculation or fetch it similarly
          return Card(
            child: Container(
              width: 300, // Set a finite width here
              child: ListTile(
                leading: const Icon(Icons.account_circle),
                title: Text(request.username.toString()),
                subtitle: Text(
                    '${request.distance?.toInt() ?? 'Calculating...'} m'), // Replace with actual distance logic
                trailing: Text(request.category.toString()),
                onTap: () {
                  onSelect(request);
                },
              ),
            ),
          );
        },
      );
    } else {
      return const Center(child: Text("No data available."));
    }
  }
}
