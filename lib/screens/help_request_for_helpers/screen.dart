import 'dart:developer' as developer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../provider/activity_provider.dart';
import '../../provider/close_hrs_provider.dart';
import '../../services/supabase.dart';

class HelpRequestForHelpers extends StatefulWidget {
  HelpRequestForHelpers(
      {super.key, required this.helpRequestUserId, required this.index});
  final String? helpRequestUserId;
  final int index;

  @override
  State<HelpRequestForHelpers> createState() => _HelpRequestForHelpersState();
}

class _HelpRequestForHelpersState extends State<HelpRequestForHelpers> {
  String? userResponse;

  @override
  Widget build(BuildContext context) {
    final userId = supabase.auth.currentUser?.id;
    final helpRequestsNotifier = context.read<HelpRequestsNotifier>();

    final helpRequest = helpRequestsNotifier.helpRequests?.firstWhere(
        (r) => r.help_request_owner_id == widget.helpRequestUserId);

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
                    title: Text(
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
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: CachedNetworkImageProvider(
                          '${helpRequest?.avatar_url}'),
                    ),
                    trailing: IconButton(
                      icon: const FaIcon(FontAwesomeIcons.earthAmericas),
                      onPressed: () {
                        // ...
                      },
                    ),
                  ),
                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${helpRequest?.content}',
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 10),
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
            Row(
              children: [
                const SizedBox(width: 1),
                Expanded(
                  child: Selector<ActivityNotifier, bool>(
                    selector: (_, activityNotifier) => activityNotifier
                        .isHelping(helpRequest.help_request_owner_id),
                    builder: (context, isHelping, _) {
                      return ElevatedButton(
                        onPressed: userId != null
                            ? () {
                                if (isHelping) {
                                  Provider.of<ActivityNotifier>(context,
                                          listen: false)
                                      .removeMyHelpActivity(
                                          helpRequest.help_request_owner_id);
                                  developer.log(
                                      helpRequest.help_request_owner_id,
                                      name: 'removeMyHelpActivity');
                                } else {
                                  Provider.of<ActivityNotifier>(context,
                                          listen: false)
                                      .createHelpActivity(
                                          helpRequest.help_request_owner_id);
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isHelping && userId != null
                            ? Text(
                                'Cancel Help',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Text(
                                'Help',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Selector<ActivityNotifier, bool>(
              selector: (_, activityNotifier) =>
                  activityNotifier.isHelping(helpRequest.help_request_owner_id),
              builder: (context, isHelping, _) {
                return Visibility(
                  visible: isHelping,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Please use the following contact information to coordinate the help',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    overflow: TextOverflow.fade),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DefaultTabController(
                        length: 3,
                        child: SizedBox(
                          height: 500,
                          child: Column(
                            children: [
                              const TabBar(
                                tabs: [
                                  Tab(icon: Icon(Icons.phone)),
                                  Tab(icon: FaIcon(FontAwesomeIcons.xTwitter)),
                                  Tab(icon: FaIcon(FontAwesomeIcons.instagram)),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    // Phone Number Tab
                                    ListTile(
                                      title: const Text(
                                        'Phone Number',
                                      ),
                                      subtitle: const Text(
                                        '0994732982',
                                        style: TextStyle(
                                            overflow: TextOverflow.fade),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.copy),
                                        onPressed: () {
                                          Clipboard.setData(const ClipboardData(
                                              text: '0994732982'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Phone number copied to clipboard'),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'X Twitter',
                                      ),
                                      subtitle: const Text(
                                        'iamvalencia4',
                                        style: TextStyle(
                                            overflow: TextOverflow.fade),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.copy),
                                        onPressed: () {
                                          Clipboard.setData(const ClipboardData(
                                              text: '0994732982'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Phone number copied to clipboard'),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Instagram',
                                      ),
                                      subtitle: const Text(
                                        'iamvalenci4',
                                        style: TextStyle(
                                            overflow: TextOverflow.fade),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.copy),
                                        onPressed: () {
                                          Clipboard.setData(const ClipboardData(
                                              text: '0994732982'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Phone number copied to clipboard'),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Other tabs content here
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
