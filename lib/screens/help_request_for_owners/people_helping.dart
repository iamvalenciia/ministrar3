import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../models/people_helping_in_my_hr/people_helping_in_my_hr.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/people_helping_provider.dart';
import 'screen.dart';

class PeopleHelping extends StatefulWidget {
  const PeopleHelping({super.key});

  @override
  State<PeopleHelping> createState() => _PeopleHelpingState();
}

class _PeopleHelpingState extends State<PeopleHelping> {
  @override
  Widget build(BuildContext context) {
    void updateActivityStatusAndHelpRequest(
        int activityId, bool status, String username) {
      final peopleHelpingNotifier = context.read<PeopleHelpingNotifier>();
      final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
      peopleHelpingNotifier.updateActivityStatusAndHelpRequest(
          activityId, status);
      if (status) {
        myHelpRequestNotifier.updateReceiveHelpAt();
      }
    }

    Future<void> showConfirmationDialog(String username, int activityId) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@$username',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(AppLocalizations.of(context)!.ownerUserHelpsYou,
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.ownerResponseYes),
                onPressed: () {
                  updateActivityStatusAndHelpRequest(
                      activityId, true, username);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.ownerResponseNo),
                onPressed: () {
                  updateActivityStatusAndHelpRequest(
                      activityId, false, username);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    final isLoading = context
        .select<PeopleHelpingNotifier, bool?>((notifier) => notifier.isLoading);
    final peopleHelpingNotifier =
        Provider.of<PeopleHelpingNotifier>(context, listen: false);

    return Selector<PeopleHelpingNotifier, List<PeopleHelpingInMyHelpRequest>?>(
      selector: (_, notifier) => notifier.peopleHelping,
      builder: (context, peopleHelping, child) {
        if (peopleHelping == null ||
            peopleHelping.isEmpty && isLoading == false) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await peopleHelpingNotifier.fetchPeopleHelpingInMyHelpRequest();
              },
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20, left: 14),
                    child: Text(
                      AppLocalizations.of(context)!.ownerNoOneHas,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 20),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await peopleHelpingNotifier.fetchPeopleHelpingInMyHelpRequest();
            },
            child: ListView.builder(
              itemCount: peopleHelping.length,
              itemBuilder: (context, index) {
                final peopleisHelping = peopleHelping[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: peopleisHelping.avatar_url != null
                        ? CachedNetworkImageProvider(
                            '${peopleisHelping.avatar_url}')
                        : null,
                    child: peopleisHelping.avatar_url == null
                        ? const Icon(Icons.account_circle, size: 40)
                        : null,
                  ),
                  title: Text(
                    '@${peopleisHelping.username ?? ''}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Selector<PeopleHelpingNotifier, bool?>(
                    selector: (_, notifier) =>
                        notifier.peopleHelping?[index].status,
                    builder: (context, status, _) {
                      return Text(
                        '${AppLocalizations.of(context)!.ownerUserHelpsYou}  ${getStatusText(status, context)}',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.outline),
                      );
                    },
                  ),
                  trailing: Selector<PeopleHelpingNotifier, bool?>(
                    selector: (_, notifier) =>
                        notifier.peopleHelping?[index].status,
                    builder: (context, status, _) {
                      if (status == null) {
                        return Card(
                          child: IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            icon: const Icon(Icons.rate_review),
                            onPressed: () {
                              showConfirmationDialog(
                                  peopleisHelping.username ?? '',
                                  peopleisHelping.activity_id ?? 0);
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
        );
      },
    );
  }
}
