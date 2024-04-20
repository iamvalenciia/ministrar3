import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/help_requests_model/help_request_model.dart';
import '../../provider/activity_provider.dart';
import '../../provider/close_hrs_provider.dart';

class HelpRequests extends StatelessWidget {
  const HelpRequests({super.key});

  @override
  Widget build(BuildContext context) {
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
        if (helpRequests == null || helpRequests.isEmpty) {
          return const Center(
              child: Card.filled(
                  child: Padding(
            padding: EdgeInsets.all(15),
            child: const Text(
              'No help requests are currently available. Please check back later for updates',
              style: TextStyle(fontSize: 16),
            ),
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
        return GestureDetector(
          onTap: () => context.go(
              '/help-request-for-helpers/${request.help_request_owner_id}?index=$index'),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 20,
                              backgroundImage: CachedNetworkImageProvider(
                                  '${request.avatar_url}')),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '@$userName',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Selector<HelpRequestsNotifier, double>(
                                  selector: (_, notifier) =>
                                      notifier.distances?[index] ?? 1.1,
                                  builder: (_, distance, __) {
                                    return Text(
                                      distance != 1.1
                                          ? '${distance.toInt()} Km'
                                          : 'Calculating ...',
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Selector<ActivityNotifier, bool>(
                            selector: (_, activityNotifier) => activityNotifier
                                .isHelping(request.hr_id.toString()),
                            builder: (context, isHelping, _) {
                              return isHelping
                                  ? Icon(
                                      Icons.volunteer_activism,
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    )
                                  : Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    Card.outlined(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          request.content.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Text(
                            timeago.format(request.inserted_at!),
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.outline),
                          ),
                          Text(
                            ' / $category',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
