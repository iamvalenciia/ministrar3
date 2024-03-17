import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:ministrar3/screens/help_request_Details/3_dots_menu.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;
import 'package:timeago/timeago.dart' as timeago;

class HelpRequestDetails extends StatelessWidget {
  final String? helpRequestUserId;

  HelpRequestDetails({super.key, required this.helpRequestUserId});

  @override
  Widget build(BuildContext context) {
    final userId = supabase.auth.currentUser?.id;
    final helpRequestsNotifier = context.watch<HelpRequestsNotifier>();
    final myHelpRequestNotifier = context.watch<MyHelpRequestNotifier>();

    developer.log('helpRequestId: $helpRequestUserId');

    final helpRequest = userId == helpRequestUserId
        ? myHelpRequestNotifier.myHelpRequest
        : helpRequestsNotifier.helpRequests
            ?.firstWhere((r) => r.user_id == helpRequestUserId);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text('@${helpRequest?.username}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${timeago.format(helpRequest?.inserted_at ?? DateTime.now())} / ',
                          ),
                        ),
                        Card.filled(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                                helpRequest?.distance != null
                                    ? '${helpRequest?.distance!.toInt()} m'
                                    : 'Calculating ...',
                                style: TextStyle(fontStyle: FontStyle.italic)),
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(
                          '${helpRequest?.avatar_url}'),
                    ),
                    trailing: MenuAnchorExample(),
                  ),
                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${helpRequest?.content}',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
