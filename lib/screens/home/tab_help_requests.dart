import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/help_requests_model/help_request_model.dart';
import '../../provider/activity_provider.dart';
import '../../provider/close_hrs_provider.dart';

class HelpRequests extends StatelessWidget {
  const HelpRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select<HelpRequestsNotifier, bool>((notifier) => notifier.isLoading);
    final error = context
        .select<HelpRequestsNotifier, String?>((notifier) => notifier.error);
    final HelpRequestsNotifier helpRequestsNotifier =
        Provider.of<HelpRequestsNotifier>(context, listen: false);

    if (isLoading && helpRequestsNotifier.helpRequests == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
          child: Card(
              child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text('Error: $error'),
      )));
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

  Future<ColorScheme> _getColorSchemeFromImage(String? imageUrl) async {
    if (imageUrl == null) {
      return ColorScheme.fromSwatch(primarySwatch: Colors.blue);
    }
    return await ColorScheme.fromImageProvider(
      provider: CachedNetworkImageProvider(imageUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await helpRequestsNotifier.fetchHelpRequests();
            },
            child: ListView.builder(
              itemCount: helpRequests.length,
              itemBuilder: (context, index) {
                final request = helpRequests[index];
                final userName = request.username.toString();
                final category = request.category.toString();

                return FutureBuilder<ColorScheme>(
                  future: _getColorSchemeFromImage(request.avatar_url),
                  builder: (context, snapshot) {
                    final colorScheme =
                        snapshot.data ?? Theme.of(context).colorScheme;

                    return GestureDetector(
                      onTap: () => context.go(
                          '/help-request-for-helpers/${request.help_request_owner_id}'),
                      child: Card(
                        // color: colorScheme.inversePrimary,
                        surfaceTintColor: colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 280,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage:
                                            request.avatar_url != null
                                                ? CachedNetworkImageProvider(
                                                    '${request.avatar_url}')
                                                : null,
                                        child: request.avatar_url == null
                                            ? const Icon(Icons.account_circle,
                                                size: 40)
                                            : null,
                                      ),
                                      const SizedBox(width: 18),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '@$userName',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Selector<HelpRequestsNotifier,
                                              ({double distance, bool unit})>(
                                            selector: (_, notifier) => (
                                              distance:
                                                  notifier.distances![index],
                                              unit: notifier
                                                  .isDistanceInKilometers
                                            ),
                                            builder: (_, data, __) {
                                              final distance = data.distance;
                                              final isDistanceInKilometers =
                                                  data.unit;
                                              final unit =
                                                  isDistanceInKilometers
                                                      ? 'km'
                                                      : 'mi';
                                              return Text(
                                                distance != 1.1
                                                    ? '${distance.toStringAsFixed(1)} $unit'
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .homeDistance,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    timeago.format(
                                                        request.inserted_at!,
                                                        locale:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .locale),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .outline),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // Selector<ActivityNotifier,
                                                  //     bool>(
                                                  //   selector: (_,
                                                  //           activityNotifier) =>
                                                  //       activityNotifier
                                                  //           .isHelping(request
                                                  //               .hr_id
                                                  //               .toString()),
                                                  //   builder: (context,
                                                  //       isHelping, _) {
                                                  //     return isHelping
                                                  //         ? Padding(
                                                  //             padding:
                                                  //                 const EdgeInsets
                                                  //                     .only(
                                                  //                     bottom: 6,
                                                  //                     left: 10),
                                                  //             child: Icon(
                                                  //               Icons
                                                  //                   .volunteer_activism,
                                                  //               color:
                                                  //                   colorScheme
                                                  //                       .primary,
                                                  //             ),
                                                  //           )
                                                  //         : Container();
                                                  //   },
                                                  // ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .homeCategory(category),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .outline,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Card.outlined(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            request.content.toString(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Selector<ActivityNotifier, bool>(
                                      selector: (_, activityNotifier) =>
                                          activityNotifier.isHelping(
                                              request.hr_id.toString()),
                                      builder: (context, isHelping, _) {
                                        return isHelping
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.volunteer_activism,
                                                  color: colorScheme.primary,
                                                ),
                                              )
                                            : Container();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
