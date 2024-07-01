import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../provider/my_hr_provider.dart';
import '../../provider/people_helping_provider.dart';
import '../../provider/user_provider.dart';
import 'people_helping.dart';
import 'settings.dart';

class HelpRequestForOwners extends StatefulWidget {
  HelpRequestForOwners({super.key});

  @override
  State<HelpRequestForOwners> createState() => _HelpRequestForOwnersState();
}

class _HelpRequestForOwnersState extends State<HelpRequestForOwners> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor, zIndex: 2, name: 'SomeName');
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName('SomeName');
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    context.go('/');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
    context.read<PeopleHelpingNotifier>();

    final helpRequest = myHelpRequestNotifier.myHelpRequest!;

    final username = context.select((UserNotifier un) => un.user?.username);

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: 10),
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
                            child: Card.filled(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .ownerCongratulations,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 10), // Add some spacing
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
                            '${receiveHelpAt == null ? 0 : DateTime.now().difference(receiveHelpAt).inHours}/${AppLocalizations.of(context)!.owner24Hours}',
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
              padding: const EdgeInsets.symmetric(horizontal: 5),
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
                              child: Selector<MyHelpRequestNotifier,
                                  ({double distance, bool unit})>(
                                selector: (_, notifier) => (
                                  distance: notifier.distance ?? 1.1,
                                  unit: notifier.isDistanceInKilometers
                                ),
                                builder: (_, data, __) {
                                  final distance = data.distance;
                                  final isDistanceInKilometers = data.unit;
                                  final unit =
                                      isDistanceInKilometers ? 'km' : 'mi';
                                  return Text(
                                    distance != null
                                        ? '${distance.toStringAsFixed(1)} $unit'
                                        : AppLocalizations.of(context)!
                                            .homeDistance,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: helpRequest.avatar_url != null
                            ? CachedNetworkImageProvider(
                                '${helpRequest.avatar_url}')
                            : null,
                        child: helpRequest.avatar_url == null
                            ? const Icon(Icons.account_circle, size: 50)
                            : null,
                      ),
                      trailing: HelpRequestSettings(
                          helpRequestId: '${helpRequest.hr_id}')),
                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${helpRequest.content}',
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              timeago.format(helpRequest.inserted_at!,
                                  locale: AppLocalizations.of(context)!.locale),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.outline),
                            ),
                            const SizedBox(width: 5),
                            const Text('/'),
                            const SizedBox(width: 5),
                            Text(
                              AppLocalizations.of(context)!.homeCategory(
                                  helpRequest.category.toString()),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.outline),
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
            const PeopleHelping()
          ],
        ),
      ),
    );
  }
}

String getStatusText(bool? status, BuildContext context) {
  if (status == true) {
    return AppLocalizations.of(context)!.ownerResponseYes;
  } else if (status == false) {
    return AppLocalizations.of(context)!.ownerResponseNo;
  } else {
    return '';
  }
}
