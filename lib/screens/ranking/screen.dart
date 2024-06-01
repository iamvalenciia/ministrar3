import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../models/user_ranking_model/user_ranking_model.dart';
import '../../provider/user_ranking_provider.dart';
import '../../services/supabase.dart';

class UserRakingList extends StatefulWidget {
  const UserRakingList({super.key});

  @override
  State<UserRakingList> createState() => _UserRakingListState();
}

class _UserRakingListState extends State<UserRakingList> {
  @override
  Widget build(BuildContext context) {
    final UserRankingNotifier userRankingNotifier =
        Provider.of<UserRankingNotifier>(context, listen: false);
    return Selector<UserRankingNotifier, List<UserRanking>?>(
      selector: (_, notifier) => notifier.userRakingAndNeighbors,
      builder: (context, userRakingAndNeighbors, child) {
        if (userRakingAndNeighbors == null) {
          return Center(
            child: ElevatedButton(
              onPressed: () async {
                userRankingNotifier.fetchUserRakingAndNeighbors();
              },
              child: const Text('Refresh/Actualizar'),
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.ranking,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline),
                    ),
                    Text(
                      AppLocalizations.of(context)!.rankingPeopleHelped,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline),
                    ),
                  ],
                ),
              ),
              ...userRakingAndNeighbors!.map(
                (user) => Card(
                  color: user.user_id == supabase.auth.currentUser?.id
                      ? Theme.of(context).colorScheme.inversePrimary
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 20, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        Text('#${user.user_position}'),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: user.avatar_url != null
                              ? CachedNetworkImageProvider('${user.avatar_url}')
                              : null,
                          child: user.avatar_url == null
                              ? const Icon(Icons.account_circle, size: 40)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.full_name ?? '',
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('@${user.username}'),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${user.help_count}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Card.filled(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.rankingInfo,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
