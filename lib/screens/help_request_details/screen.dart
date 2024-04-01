import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../provider/close_hrs_provider.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/supabase.dart';
import 'help_request_settings.dart';

class HelpRequestDetails extends StatelessWidget {
  HelpRequestDetails(
      {super.key, required this.helpRequestUserId, required this.index});
  final String? helpRequestUserId;
  final int index;

  @override
  Widget build(BuildContext context) {
    final userId = supabase.auth.currentUser?.id;
    final helpRequestsNotifier = context.read<HelpRequestsNotifier>();
    final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();

    final helpRequest = userId == helpRequestUserId
        ? myHelpRequestNotifier.myHelpRequest
        : helpRequestsNotifier.helpRequests
            ?.firstWhere((r) => r.user_id == helpRequestUserId);

    final username = context.select((UserNotifier un) => un.user?.username);

    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: userId == helpRequestUserId
                      ? Text('@$username')
                      : Text('@${helpRequest?.username}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          helpRequest != null && helpRequest.inserted_at != null
                              ? timeago.format(helpRequest.inserted_at!)
                              : 'No Time Error',
                        ),
                      ),
                      Card.filled(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Selector<HelpRequestsNotifier, double>(
                            selector: (_, notifier) =>
                                notifier.distances![index],
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
                  trailing: userId == helpRequest?.user_id
                      ? HelpRequestSettings(helpRequestId: '${helpRequest?.id}')
                      : null,
                ),
                Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${helpRequest?.content}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
