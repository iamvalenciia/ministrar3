import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_routes.dart';
import '../../models/help_requests_model/help_request_model.dart';
import '../../models/user_model/user_model.dart';
import '../../provider/close_hrs_provider.dart';
import '../../provider/conectivity_provider.dart';
import '../../provider/user_provider.dart';
import '../../utility_functions.dart';

class HelpRequests extends StatelessWidget {
  const HelpRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select<HelpRequestsNotifier, bool>((notifier) => notifier.isLoading);
    final HelpRequestsNotifier helpRequestsNotifier =
        Provider.of<HelpRequestsNotifier>(context, listen: false);
    final ConnectivityProvider connectivityStatus =
        Provider.of<ConnectivityProvider>(context, listen: false);
    final error = context
        .select<HelpRequestsNotifier, String?>((notifier) => notifier.error);

    if (isLoading && helpRequestsNotifier.helpRequests == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (connectivityStatus.status == ConnectivityStatus.Offline) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(AppLocalizations.of(context)!.homeNoInternet),
            ),
          ],
        ),
      );
    }

    if (error != null) {
      return Center(
          child: Card(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(AppLocalizations.of(context)!.homeOhNoSomething)),
      ));
    }

    return Selector<HelpRequestsNotifier, List<HelpRequestModel>?>(
      selector: (_, notifier) => notifier.helpRequests,
      builder: (context, helpRequests, child) {
        if (helpRequests == null || helpRequests.isEmpty) {
          return Center(
              child: Card.filled(
                  child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              AppLocalizations.of(context)!.homeNoHelpRequests,
              style: const TextStyle(fontSize: 16),
            ),
          )));
        }

        return HelpRequestsList(
            helpRequests: helpRequests,
            helpRequestsNotifier: helpRequestsNotifier);
      },
    );
  }
}

class HelpRequestsList extends StatelessWidget {
  HelpRequestsList(
      {super.key,
      required this.helpRequests,
      required this.helpRequestsNotifier});
  final List<HelpRequestModel> helpRequests;
  final HelpRequestsNotifier helpRequestsNotifier;

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.read<UserNotifier>().user;
    return RefreshIndicator(
      onRefresh: () async {
        await helpRequestsNotifier.fetchHelpRequests();
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ministrar',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Text(' 3 stars')
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                    left: 12, right: 8, bottom: 20, top: 2),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: user?.avatar_url != null
                          ? CachedNetworkImageProvider('${user?.avatar_url}')
                          : null,
                      child: user?.avatar_url == null
                          ? const Icon(Icons.account_circle, size: 40)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8, top: 8.0, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user!.username
                                      .toString(), // Replace with actual username
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  'Need a hand? Create a help request now!', // Replace with actual text
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final request = helpRequests[index];
                final userName = request.username.toString();
                final fullName = request.full_name.toString();
                final colorScheme = helpRequestsNotifier
                        .colorSchemes[request.hr_id.toString()] ??
                    Theme.of(context).colorScheme;

                return Container(
                  // color: colorScheme.primary.withOpacity(0.1),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                      AppRoutes.helpRequest,
                      arguments: {'id': request.help_request_owner_id},
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          height: 0,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: request.avatar_url != null
                                    ? CachedNetworkImageProvider(
                                        '${request.avatar_url}')
                                    : null,
                                child: request.avatar_url == null
                                    ? const Icon(Icons.account_circle, size: 40)
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 200),
                                                child: Text(
                                                  fullName,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    userName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                  const Text(' · '),
                                                  Text(
                                                    request.category.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                  const Text(' · '),
                                                  Text(
                                                    personalizedTimeAgo(
                                                        request.inserted_at!),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Card.outlined(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '3',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(request.content.toString(),
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: helpRequests.length,
            ),
          ),
        ],
      ),
    );
  }
}
