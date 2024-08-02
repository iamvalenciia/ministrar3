import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// import '../../provider/activity_provider.dart';
import '../../app_routes.dart';
import '../../badgets/mosaico.dart';
import '../../provider/conectivity_provider.dart';
// import '../../provider/help_points.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/user_provider.dart';

class MyHelpRequest extends StatelessWidget {
  const MyHelpRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final userExist = Provider.of<UserNotifier>(context).isUserLoggedIn;
    final username = Provider.of<UserNotifier>(context).user?.username;
    final myHelpRequest =
        Provider.of<MyHelpRequestNotifier>(context).myHelpRequest;
    // final bool wasLastActivityHelpTrue =
    //     context.read<ActivityNotifier>().wasLastActivityHelpTrue;
    // final int helpPoint = Provider.of<HelpPoints>(context).helpPoints;
    final ConnectivityProvider connectivityStatus =
        Provider.of<ConnectivityProvider>(context, listen: false);

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

    if (myHelpRequest != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              // scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Card(
                  child: SizedBox(
                    width: 300, // Set a finite width here
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: myHelpRequest.avatar_url != null
                            ? CachedNetworkImageProvider(
                                '${myHelpRequest.avatar_url}')
                            : null,
                        child: myHelpRequest.avatar_url == null
                            ? const Icon(Icons.account_circle, size: 40)
                            : null,
                      ),
                      title: Text(
                        username.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Selector<MyHelpRequestNotifier,
                          ({double distance, bool unit})>(
                        selector: (_, notifier) => (
                          distance: notifier.distance ?? 1.1,
                          unit: notifier.isDistanceInKilometers
                        ),
                        builder: (_, data, __) {
                          final distance = data.distance;
                          final isDistanceInKilometers = data.unit;
                          final unit = isDistanceInKilometers ? 'km' : 'mi';
                          return Text(
                            distance != 1.1
                                ? '${distance.toStringAsFixed(1)} $unit'
                                : AppLocalizations.of(context)!.homeDistance,
                          );
                        },
                      ),
                      trailing: Text(
                        AppLocalizations.of(context)!
                            .homeCategory(myHelpRequest.category.toString()),
                        style: const TextStyle(fontSize: 15),
                      ),
                      onTap: () => Navigator.of(context).pushNamed(
                        AppRoutes.myHelpRequest,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else if (userExist) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: userExist
                    ? () => Navigator.of(context).pushNamed(
                          AppRoutes.createHelpRequest,
                        )
                    : null,
                child: Row(
                  children: [
                    const Icon(Icons.post_add),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.homeCreateAHelpRequest),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 200, // Set a fixed height
            child: MarioPixelArt(),
          ),
        ],
      );
    } else if (!userExist) {
      return Center(
        child: Card.filled(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Text(
              AppLocalizations.of(context)!.homePleaseLogin,
              // style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
