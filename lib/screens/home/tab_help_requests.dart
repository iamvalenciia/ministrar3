import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/help_requests_model/help_request_model.dart';
import '../../provider/close_hrs_provider.dart';

class HelpRequests extends StatelessWidget {
  const HelpRequests({super.key});

  @override
  Widget build(BuildContext context) {
    developer.log('Building HelpRequests');

    final isLoading = context
        .select<HelpRequestsNotifier, bool>((notifier) => notifier.isLoading);
    final error = context
        .select<HelpRequestsNotifier, String?>((notifier) => notifier.error);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
          child: Card(
              child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text('Error: $error'),
      )));
    }

    return Selector<HelpRequestsNotifier, List<HelpRequestModel>?>(
      selector: (_, notifier) => notifier.helpRequests,
      builder: (context, helpRequests, child) {
        developer.log('building help requests list');

        if (helpRequests == null || helpRequests.isEmpty) {
          return const Center(
              child: Card(
                  child: Padding(
            padding: EdgeInsets.all(15),
            child: const Text(
                'No help requests are currently available. Please check back later for updates.'),
          )));
        }

        return HelpRequestsList(helpRequests: helpRequests);
      },
    );
  }
}

// -----------------------------------------/
//  widget used in the ProfileScreen widget /
//------------------------------------------/
class HelpRequestsList extends StatelessWidget {
  HelpRequestsList({super.key, required this.helpRequests});
  final List<HelpRequestModel> helpRequests;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: helpRequests.length,
      itemBuilder: (context, index) {
        final request = helpRequests[index];
        final userName = request.username.toString();
        final category = request.category.toString();
        return Card(
          child: SizedBox(
            width: 300,
            child: ListTile(
              title: Text(
                userName,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(category),
              leading: const Icon(Icons.account_circle),
              subtitle: Selector<HelpRequestsNotifier, double>(
                selector: (_, notifier) => notifier.distances?[index] ?? 1.1,
                builder: (_, distance, __) {
                  return Text(
                    distance != 1.1
                        ? '${distance.toInt()} meters'
                        : 'Calculating ...',
                  );
                },
              ),
              onTap: () => context
                  .go('/help-request-details/${request.user_id}?index=$index'),
            ),
          ),
        );
      },
    );
  }
}
