import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../provider/activity_provider.dart';
import '../../provider/close_hrs_provider.dart';
import '../../provider/location_permission.dart';
import '../../provider/user_provider.dart';
import '../../services/supabase.dart';
import '../../utility_functions.dart';
import '../home/login_card.dart';

class HelpRequestForHelpers extends StatefulWidget {
  HelpRequestForHelpers({super.key, required this.helpRequestUserId});
  final String? helpRequestUserId;

  @override
  State<HelpRequestForHelpers> createState() => _HelpRequestForHelpersState();
}

class _HelpRequestForHelpersState extends State<HelpRequestForHelpers> {
  String? userResponse;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor, zIndex: 2, name: 'forHelpers');
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName('forHelpers');
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    context.go('/');
    return true;
  }

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
    final locationPermissionNotifier =
        Provider.of<LocationPermissionNotifier>(context);

    final List<Widget> tabs = [];
    final List<Widget> tabViews = [];

    if (helpRequest.phone_number != null &&
        helpRequest.phone_number != '' &&
        helpRequest.phone_number!.isNotEmpty) {
      tabs.add(const Tab(icon: Icon(Icons.phone)));
      tabViews.add(
        ListTile(
          title: Text(AppLocalizations.of(context)!.helperPhoneNumber),
          subtitle: Text(helpRequest.phone_number!,
              style: const TextStyle(overflow: TextOverflow.fade)),
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(
                  ClipboardData(text: helpRequest.phone_number.toString()));
              showFlashSuccess(context,
                  AppLocalizations.of(context)!.helperPhoneNumberCopied);
            },
          ),
        ),
      );
    }

    if (helpRequest.x_username != null &&
        helpRequest.x_username != '' &&
        helpRequest.x_username!.isNotEmpty) {
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
              showFlashSuccess(
                  context, AppLocalizations.of(context)!.helperXTwitterCopied);
            },
          ),
        ),
      );
    }

    if (helpRequest.instagram_username != null &&
        helpRequest.instagram_username != '' &&
        helpRequest.instagram_username!.isNotEmpty) {
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
              showFlashSuccess(
                  context, AppLocalizations.of(context)!.helperXTwitterCopied);
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
                              child: Card.filled(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .helperHelpRequestWillBeHidden,
                                    style: const TextStyle(fontSize: 15),
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
                              '${helpRequest.receive_help_at == null ? 0 : DateTime.now().difference(helpRequest.receive_help_at!).inHours}/${AppLocalizations.of(context)!.owner24Hours}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.outline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                    trailing: Visibility(
                      visible: helpRequest.location_sharing_enabled == true,
                      child: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          MapsLauncher.launchCoordinates(
                              helpRequest.lat!, helpRequest.long!);
                        },
                      ),
                    ),
                  ),
                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${helpRequest.content}',
                          style: const TextStyle(
                            fontSize: 18,
                          )),
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
                                              ? ' ${AppLocalizations.of(context)!.helperPersonHelping}'
                                              : ' ${AppLocalizations.of(context)!.helperPeopleHelping}';
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
                                              ? ' ${AppLocalizations.of(context)!.helperPersonProvidedHelp}'
                                              : ' ${AppLocalizations.of(context)!.helperPeopleProvidedHelp}';
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
            // Visibility(
            //     visible: helped != null, child: const SizedBox(height: 20)),
            Visibility(
              visible: helped == true,
              child: Card.filled(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.helperThankYou,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: helped == false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.helperThanksForTrying,
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
                    child: Selector<ActivityNotifier,
                        ({bool isHelping, bool isLoading})>(
                      selector: (_, activityNotifier) => (
                        isHelping: activityNotifier.isHelping(
                          helpRequest.hr_id.toString(),
                        ),
                        isLoading: activityNotifier.isLoadingHelpBotton,
                      ),
                      builder: (context, data, _) {
                        return FilledButton(
                          onPressed: userId != null
                              ? () {
                                  if (data.isHelping) {
                                    context
                                        .read<ActivityNotifier>()
                                        .removeMyHelpActivity(
                                          helpRequest.hr_id,
                                        );
                                    helpRequestsNotifier
                                        .decrementPeopleHelpingCount(
                                      helpRequest.hr_id,
                                    );
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
                          child: data.isLoading
                              ? const LinearProgressIndicator()
                              : data.isHelping && userId != null
                                  ? Text(
                                      AppLocalizations.of(context)!
                                          .helperCalcelhelp,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.helperHelp,
                                      style: const TextStyle(
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
            Selector<UserNotifier, bool>(
              selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
              builder: (_, userExist, __) => Visibility(
                visible: !userExist &&
                    locationPermissionNotifier.hasLocationPermission,
                child: const LoginCard(),
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
                                  AppLocalizations.of(context)!
                                      .helperUseTheFollowingInformation,
                                  style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
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
