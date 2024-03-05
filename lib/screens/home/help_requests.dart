// help_requests.dart
import 'package:flutter/material.dart';
import 'package:ministrar3/provider/help_req_provider.dart';
import 'package:provider/provider.dart';

class HelpRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the notifier
    final helpRequestsNotifier = context.watch<HelpRequestsNotifier>();
    final helpRequests = helpRequestsNotifier.helpRequests;
    final isLoading = helpRequestsNotifier.isLoading;
    final isFirstLoad = helpRequestsNotifier.isFirstLoad;
    final error = helpRequestsNotifier.error;

    if (isLoading && isFirstLoad) {
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
