import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../provider/my_hr_provider.dart';
import '../../provider/people_helping_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/supabase.dart';
import 'help_request_settings.dart';

class HelpRequestForOwners extends StatefulWidget {
  HelpRequestForOwners({super.key, required this.index});
  final int index;

  @override
  State<HelpRequestForOwners> createState() => _HelpRequestForOwnersState();
}

class _HelpRequestForOwnersState extends State<HelpRequestForOwners> {
  String? userResponse;

  void _updateActivityStatusAndHelpRequest(
      int activityId, bool status, String username) {
    final peopleHelpingNotifier = context.read<PeopleHelpingNotifier>();
    final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
    peopleHelpingNotifier.updateActivityStatusAndHelpRequest(
        activityId, status);
    if (status) {
      myHelpRequestNotifier.updateReceiveHelpAt();
    }
    setState(() {
      userResponse = status ? 'Yes' : 'No';
    });
  }

  Future<void> _showConfirmationDialog(String username, int activityId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            '@$username helps you?',
            style: const TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _updateActivityStatusAndHelpRequest(activityId, true, username);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                _updateActivityStatusAndHelpRequest(
                    activityId, false, username);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = supabase.auth.currentUser?.id;

    final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
    final peopleHelping = context.read<PeopleHelpingNotifier>().peopleHelping;
    final helpRequest = myHelpRequestNotifier.myHelpRequest!;

    final username = context.select((UserNotifier un) => un.user?.username);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Selector<MyHelpRequestNotifier, DateTime?>(
                selector: (_, notifier) =>
                    notifier.myHelpRequest?.receive_help_at,
                builder: (_, receiveHelpAt, __) {
                  return Visibility(
                    visible: receiveHelpAt != null,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Card.outlined(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Congratulations on receiving help! Your request will automatically be removed in 24 hours, or you can choose to remove it now',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10), // Add some spacing
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: receiveHelpAt == null
                                    ? 0
                                    : DateTime.now()
                                            .difference(receiveHelpAt)
                                            .inHours /
                                        24,
                              ),
                            ),
                            const SizedBox(width: 10), // Add some spacing
                            Text(
                              '${receiveHelpAt == null ? 0 : DateTime.now().difference(receiveHelpAt).inHours}/24 hours',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text('@$username'),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card.filled(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Selector<MyHelpRequestNotifier, double>(
                                selector: (_, notifier) =>
                                    notifier.distance ?? 1.1,
                                builder: (_, distance, __) {
                                  return Text(
                                    distance != 1.1
                                        ? '${distance.toInt()} Km'
                                        : 'Calculating ...',
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                              '${helpRequest.avatar_url}')),
                      trailing: userId == helpRequest.help_request_owner_id
                          ? HelpRequestSettings(
                              helpRequestId: '${helpRequest.hr_id}')
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${helpRequest.content}',
                          style: const TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                timeago.format(helpRequest.inserted_at!),
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.outline),
                              ),
                              const SizedBox(width: 5),
                              const Text('/'),
                              const SizedBox(width: 5),
                              Text(
                                helpRequest.category.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListView.builder(
                    itemCount: peopleHelping?.length ?? 0,
                    itemBuilder: (context, index) {
                      final peopleisHelping = peopleHelping?[index];
                      return ListTile(
                        leading: CircleAvatar(
                            radius: 18,
                            backgroundImage: CachedNetworkImageProvider(
                                '${peopleisHelping?.avatar_url}')),
                        title: Text(
                          '@${peopleisHelping?.username ?? ''}',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Selector<PeopleHelpingNotifier, bool?>(
                          selector: (_, peopleHelpingNotifier) =>
                              peopleHelpingNotifier
                                  .peopleHelping![index].status,
                          builder: (context, status, _) {
                            return Text(
                              'helps you?  ${getStatusText(status)}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.outline),
                            );
                          },
                        ),
                        trailing: Selector<PeopleHelpingNotifier, bool?>(
                          selector: (_, peopleHelpingNotifier) =>
                              peopleHelpingNotifier
                                  .peopleHelping![index].status,
                          builder: (context, status, _) {
                            if (status == null) {
                              return Card(
                                child: IconButton(
                                  color: Theme.of(context).colorScheme.primary,
                                  icon: const Icon(Icons.rate_review),
                                  onPressed: () {
                                    _showConfirmationDialog(
                                        peopleisHelping?.username ?? '',
                                        peopleisHelping?.activity_id ?? 0);
                                  },
                                ),
                              );
                            }
                            return const SizedBox(width: 0);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getStatusText(bool? status) {
  if (status == true) {
    return 'Yes';
  } else if (status == false) {
    return 'No';
  } else {
    return '';
  }
}
