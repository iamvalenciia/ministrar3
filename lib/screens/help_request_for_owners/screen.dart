import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../provider/close_hrs_provider.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/people_helping_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/supabase.dart';
import 'help_request_settings.dart';

class HelpRequestForOwners extends StatefulWidget {
  HelpRequestForOwners(
      {super.key, required this.helpRequestUserId, required this.index});
  final String? helpRequestUserId;
  final int index;

  @override
  State<HelpRequestForOwners> createState() => _HelpRequestForOwnersState();
}

class _HelpRequestForOwnersState extends State<HelpRequestForOwners> {
  String? userResponse;

  Future<void> _showConfirmationDialog(String response) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chat_bubble),
              SizedBox(width: 10),
            ],
          ),
          content: response == 'Yes'
              ? RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      height: 1.2,
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: 'This action '),
                      TextSpan(
                        text: 'will increment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' the number of mistered persons in the profile of @alguienopppp',
                      ),
                      const TextSpan(
                          text:
                              ' (Just in case is the first time you receive help from this user)',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey, height: 1.5)),
                    ],
                  ),
                )
              : RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.2,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: 'This action '),
                      TextSpan(
                        text: 'will not increment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' the number of mistered persons in the profile of @alguienopppp',
                      ),
                    ],
                  ),
                ),
          actions: <Widget>[
            FilledButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: const Text(
                'Accept',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                setState(() {
                  userResponse = response;
                });
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
    final peopleHelpingNotifier = context.read<PeopleHelpingNotifier>();

    final helpRequest = myHelpRequestNotifier.myHelpRequest;
    final peopleHelping = peopleHelpingNotifier.peopleHelping;

    final username = context.select((UserNotifier un) => un.user?.username);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: userId == widget.helpRequestUserId
                        ? Text('@$username')
                        : Text(
                            '@${helpRequest?.username}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card.filled(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Selector<HelpRequestsNotifier, double>(
                              selector: (_, notifier) =>
                                  notifier.distances![widget.index],
                              builder: (_, distance, __) {
                                return Text(
                                  distance != 1.1
                                      ? '${distance.toInt()} m'
                                      : 'Calculating ...',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: helpRequest != null
                          ? CachedNetworkImageProvider(
                              '${helpRequest.avatar_url}')
                          : null,
                    ),
                    trailing: userId == helpRequest?.help_request_owner_id
                        ? HelpRequestSettings(
                            helpRequestId: '${helpRequest?.id}')
                        : null,
                  ),
                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${helpRequest?.content}',
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          timeago.format(helpRequest!.inserted_at!),
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.outline),
                        ),
                        const SizedBox(width: 5),
                        const Text('/'),
                        const SizedBox(width: 5),
                        Text(
                          helpRequest.category.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.outline),
                        ),
                        const SizedBox(width: 5),
                        const Text('•'),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.people,
                          size: 14,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '100',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                TextSpan(
                                  text: ' People Helping',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300, // specify the height as per your need
              child: Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: peopleHelping?.length ?? 0,
                      itemBuilder: (context, index) {
                        final helpRequest = peopleHelping?[index];
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 18,
                            backgroundImage: helpRequest != null
                                ? CachedNetworkImageProvider(
                                    '${helpRequest.avatar_url}')
                                : null,
                          ),
                          title: Text(
                            '@${helpRequest?.username ?? ''}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            'helps you?  ${userResponse ?? ''}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          trailing: userResponse == null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          _showConfirmationDialog('Yes');
                                        },
                                        child: const Text('Yes')),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        _showConfirmationDialog('No');
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
