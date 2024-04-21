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
import '../../utility_functions.dart';

class HelpRequestForHelpers extends StatefulWidget {
  HelpRequestForHelpers({super.key, required this.helpRequestUserId});
  final String? helpRequestUserId;

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
    final index = helpRequestsNotifier.helpRequests?.indexWhere(
        (r) => r.help_request_owner_id == widget.helpRequestUserId);
    final bool? helped =
        context.read<ActivityNotifier>().helped(helpRequest!.hr_id.toString());

    final List<Widget> tabs = [];
    final List<Widget> tabViews = [];

    if (helpRequest.phone_number != null) {
      tabs.add(const Tab(icon: Icon(Icons.phone)));
      tabViews.add(
        ListTile(
          title: const Text('Phone Number'),
          subtitle: Text(helpRequest.phone_number!,
              style: const TextStyle(overflow: TextOverflow.fade)),
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(
                  ClipboardData(text: helpRequest.phone_number.toString()));
              showFlashSuccess(context, 'Phone number copied to clipboard');
            },
          ),
        ),
      );
    }

    if (helpRequest.x_username != null) {
      tabs.add(const Tab(icon: FaIcon(FontAwesomeIcons.xTwitter)));
      tabViews.add(
        ListTile(
          title: const Text('X Twitter'),
          subtitle: Text(helpRequest.x_username!,
              style: const TextStyle(overflow: TextOverflow.fade)),
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(
                  ClipboardData(text: helpRequest.x_username.toString()));
              showFlashSuccess(context, 'Phone number copied to clipboard');
            },
          ),
        ),
      );
    }

    if (helpRequest.instagram_username != null) {
      tabs.add(const Tab(icon: Icon(FontAwesomeIcons.instagram)));
      tabViews.add(
        ListTile(
          title: const Text('Instagram'),
          subtitle: Text(helpRequest.instagram_username!,
              style: const TextStyle(overflow: TextOverflow.fade)),
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(
                  text: helpRequest.instagram_username.toString()));
              showFlashSuccess(context, 'Phone number copied to clipboard');
            },
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Visibility(
                    visible: helpRequest.receive_help_at != null,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Card.outlined(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'The help request will be hidden 24 hours after assistance has been provided',
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
                                value: helpRequest.receive_help_at == null
                                    ? 0
                                    : DateTime.now()
                                            .difference(
                                                helpRequest.receive_help_at!)
                                            .inHours /
                                        24,
                              ),
                            ),
                            const SizedBox(width: 10), // Add some spacing
                            Text(
                              '${helpRequest.receive_help_at == null ? 0 : DateTime.now().difference(helpRequest.receive_help_at!).inHours}/24 hours',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '@${helpRequest.username}',
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
                            child: Selector<HelpRequestsNotifier,
                                ({double distance, bool unit})>(
                              selector: (_, notifier) => (
                                distance: notifier.distances![index!],
                                unit: notifier.isDistanceInKilometers
                              ),
                              builder: (_, data, __) {
                                final distance = data.distance;
                                final isDistanceInKilometers = data.unit;
                                final unit =
                                    isDistanceInKilometers ? 'km' : 'mi';
                                return Text(
                                  distance != 1.1
                                      ? '${distance.toInt()} $unit'
                                      : 'Calculating ...',
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(
                          '${helpRequest.avatar_url}'),
                    ),
                    trailing: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.treeCity,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        // ...
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${helpRequest.content}',
                        style: const TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 10),
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
                          ],
                        ),
                        Row(
                          children: [
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
                                    WidgetSpan(
                                      child:
                                          Selector<HelpRequestsNotifier, int?>(
                                        selector: (_, helpRequestsNotifier) =>
                                            helpRequestsNotifier.helpRequests!
                                                .firstWhere((hr) =>
                                                    hr.hr_id ==
                                                    helpRequest.hr_id)
                                                .people_helping_count,
                                        builder:
                                            (context, peopleHelpingCount, _) {
                                          return Text(
                                            '$peopleHelpingCount',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Selector<HelpRequestsNotifier,
                                          String>(
                                        selector: (_, helpRequestsNotifier) {
                                          final peopleHelpingCount =
                                              helpRequestsNotifier.helpRequests!
                                                  .firstWhere((hr) =>
                                                      hr.hr_id ==
                                                      helpRequest.hr_id)
                                                  .people_helping_count;
                                          return peopleHelpingCount == 1
                                              ? ' Person helping'
                                              : ' People helping';
                                        },
                                        builder: (context, helpingText, _) {
                                          return Text(
                                            helpingText,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
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
                                    WidgetSpan(
                                      child:
                                          Selector<HelpRequestsNotifier, int?>(
                                        selector: (_, helpRequestsNotifier) =>
                                            helpRequestsNotifier.helpRequests!
                                                .firstWhere((hr) =>
                                                    hr.hr_id ==
                                                    helpRequest.hr_id)
                                                .people_provide_help_count,
                                        builder: (context,
                                            peopleProvideHelpCount, _) {
                                          return Text(
                                            '$peopleProvideHelpCount',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Selector<HelpRequestsNotifier,
                                          String>(
                                        selector: (_, helpRequestsNotifier) {
                                          final peopleProvideHelpCount =
                                              helpRequestsNotifier.helpRequests!
                                                  .firstWhere((hr) =>
                                                      hr.hr_id ==
                                                      helpRequest.hr_id)
                                                  .people_provide_help_count;
                                          return peopleProvideHelpCount == 1
                                              ? ' Person provided help'
                                              : ' People provided help';
                                        },
                                        builder: (context, helpingText, _) {
                                          return Text(
                                            helpingText,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(visible: helped != null, child: const Divider()),
            Visibility(
              visible: helped == true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Thank you for your help!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: helped == false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Thank you for trying to help!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: helped == null,
              child: Row(
                children: [
                  const SizedBox(width: 1),
                  Expanded(
                    child: Selector<ActivityNotifier, bool>(
                      selector: (_, activityNotifier) => activityNotifier
                          .isHelping(helpRequest.hr_id.toString()),
                      builder: (context, isHelping, _) {
                        return ElevatedButton(
                          onPressed: userId != null
                              ? () {
                                  if (isHelping) {
                                    developer.log(
                                        'helpRequest.hr_id: ${helpRequest.hr_id}',
                                        name: 'removeMyHelpActivity');
                                    context
                                        .read<ActivityNotifier>()
                                        .removeMyHelpActivity(
                                          helpRequest.hr_id,
                                        );
                                    helpRequestsNotifier
                                        .decrementPeopleHelpingCount(
                                      helpRequest.hr_id,
                                    );
                                    developer.log(
                                        helpRequest.help_request_owner_id,
                                        name: 'removeMyHelpActivity');
                                  } else {
                                    context
                                        .read<ActivityNotifier>()
                                        .createHelpActivity(helpRequest.hr_id,
                                            helpRequest.help_request_owner_id);
                                    helpRequestsNotifier
                                        .incrementPeopleHelpingCount(
                                      helpRequest.hr_id,
                                    );
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
            ),
            Visibility(
              visible: helped == null,
              child: Selector<ActivityNotifier, bool>(
                selector: (_, activityNotifier) =>
                    activityNotifier.isHelping(helpRequest.hr_id.toString()),
                builder: (context, isHelping, _) {
                  return Visibility(
                    visible: isHelping,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
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
                        Card.outlined(
                          child: DefaultTabController(
                            length: tabs.length,
                            child: SizedBox(
                              height: 120,
                              child: Column(
                                children: [
                                  TabBar(
                                    tabs: tabs,
                                  ),
                                  Expanded(
                                    child: TabBarView(children: tabViews),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
