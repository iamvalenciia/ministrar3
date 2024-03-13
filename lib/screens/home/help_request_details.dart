import 'package:flutter/material.dart';
import 'package:ministrar3/models/help_requests_model/help_request_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class HelpRequestDetails extends StatelessWidget {
  final HelpRequestModel request;
  final VoidCallback onBack;

  HelpRequestDetails({required this.request, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final userId = supabase.auth.currentUser?.id;
    final helpRequestsNotifier = context.watch<HelpRequestsNotifier>();
    final myHelpRequestNotifier = context.watch<MyHelpRequestNotifier>();

    final updatedRequest = userId == request.user_id
        ? myHelpRequestNotifier.myHelpRequest
        : helpRequestsNotifier.helpRequests
            ?.firstWhere((r) => r.id == request.id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,

          title: Card.outlined(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${request.category}'),
          )),
          leading: IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text('@${request.username}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${timeago.format(request.inserted_at!)}'),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            CachedNetworkImageProvider('${request.avatar_url}'),
                      ),
                      trailing: Card.filled(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            '${updatedRequest?.distance?.toInt() ?? 'Calculating...'} m'),
                      )),
                    ),
                    Card.outlined(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${request.content}',
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
      ),
    );
  }
}
