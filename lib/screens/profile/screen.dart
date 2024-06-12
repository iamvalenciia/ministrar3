import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tuple/tuple.dart';

import '../../models/activity_model/activity_model.dart';
import '../../models/user_model/user_model.dart';
import '../../provider/activity_provider.dart';
import '../../provider/loading_provider.dart';
import '../../provider/location_permission.dart';
import '../../provider/people_helping_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/supabase.dart';
import '../../utility_functions.dart';
import '../home/username_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isExpanded = false; // State variable to track expansion

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
    final UserModel? user = context.read<UserNotifier>().user;
    final userNotifier = context.read<UserNotifier>();
    final peopleHelped = context.read<UserNotifier>().peopleHelped;
    final activityNotifier = context.read<ActivityNotifier>();
    final peopleHelpingNotifier = context.read<PeopleHelpingNotifier>();
    final locationPermissionNotifier =
        Provider.of<LocationPermissionNotifier>(context);

    return Scaffold(
      body: Column(
        children: [
          Selector<UserNotifier, Tuple2<bool, String?>>(
            selector: (_, userNotifier) => Tuple2(
                userNotifier.isUserLoggedIn, userNotifier.user?.username),
            builder: (_, userData, __) => Visibility(
              visible: userData.item1 &&
                  locationPermissionNotifier.hasLocationPermission &&
                  userData.item2 == null,
              child: const UsernameCard(),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: user?.avatar_url != null
                  ? CachedNetworkImageProvider('${user?.avatar_url}')
                  : null,
              child: user?.avatar_url == null
                  ? const Icon(Icons.account_circle, size: 56)
                  : null,
            ),
            title: Row(
              children: [
                Flexible(
                  child: Selector<UserNotifier, String>(
                    selector: (_, notifier) =>
                        notifier.user?.username ?? 'error',
                    builder: (_, username, __) => Text(
                      '@$username',
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: Icon(Icons.settings,
                          color: Theme.of(context).colorScheme.primary),
                    );
                  },
                  menuChildren: <Widget>[
                    MenuItemButton(
                      // leadingIcon: const Icon(Icons.edit),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            AppLocalizations.of(context)!.profileEditUserName,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      onPressed: () => context.go('/username-form'),
                    ),
                    MenuItemButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            AppLocalizations.of(context)!.profileDeleteAccount,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      onPressed: () => showDialog<void>(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            content: Text(
                                AppLocalizations.of(context)!.profileAreYouSure,
                                style: const TextStyle(fontSize: 18)),
                            actions: <Widget>[
                              Consumer<LoadingNotifier>(
                                builder: (_, loadingNotifier, __) => TextButton(
                                  child: loadingNotifier.isLoading
                                      ? const CircularProgressIndicator()
                                      : Text(AppLocalizations.of(context)!
                                          .profileYesImSure),
                                  onPressed: () async {
                                    loadingNotifier.setLoading(true);
                                    try {
                                      await userNotifier.deleteMyAccount();
                                      activityNotifier.clearIsHelping();
                                      activityNotifier.clearHelpActivities();
                                      activityNotifier
                                          .clearLastFourActivities();
                                      peopleHelpingNotifier
                                          .clearPeopleHelping();
                                      await supabase.auth.signOut();
                                    } catch (e) {
                                      if (context.mounted) {
                                        showFlashError(context, '$e');
                                      }
                                    } finally {
                                      userNotifier.updateLoginStatus();
                                      loadingNotifier.setLoading(false);
                                      if (context.mounted) {
                                        Navigator.of(dialogContext).pop();
                                        context.go('/login');
                                        showFlashSuccess(
                                            context,
                                            AppLocalizations.of(context)!
                                                .profileAccountDeleted);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Text(AppLocalizations.of(context)!.profileHelped,
                    style: const TextStyle(fontSize: 16)),
                Text(' $peopleHelped ', style: const TextStyle(fontSize: 16)),
                Text(
                    peopleHelped == 1
                        ? AppLocalizations.of(context)!.profilePersonHelped
                        : AppLocalizations.of(context)!.profilePeopleHelped,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(
                  width: 10,
                ),
                // Icon(Icons.volunteer_activism,
                //     color: Theme.of(context).colorScheme.primary),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Icon(Icons.history, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Text(AppLocalizations.of(context)!.profileRecentActivities,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          Selector<ActivityNotifier, List<Activity>>(
            selector: (_, notifier) => notifier.activities ?? [],
            builder: (_, activity, __) {
              if (activity.isEmpty) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .profileThereAreNoActivities,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: activity.length,
                      itemBuilder: (context, index) {
                        final currentActivity = activity[index];
                        if (currentActivity.status == null &&
                            currentActivity.activity_type == 'help') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${AppLocalizations.of(context)!.profileIsTryingToHelpTo} @${currentActivity.help_request_owner_username}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        } else if (currentActivity.status ??
                            true && currentActivity.activity_type == 'help') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${AppLocalizations.of(context)!.profileHelpedTo} @${currentActivity.help_request_owner_username} ${timeago.format(currentActivity.status_updated_at!, locale: AppLocalizations.of(context)!.locale)}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        } else if (currentActivity.status == false &&
                            currentActivity.activity_type == 'help') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${AppLocalizations.of(context)!.profileFailedToHelpTo} @${currentActivity.help_request_owner_username} ${timeago.format(currentActivity.status_updated_at!, locale: AppLocalizations.of(context)!.locale)}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        } else if (currentActivity.activity_type == 'post') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${AppLocalizations.of(context)!.profileCreatedAhelpRequest} ${timeago.format(currentActivity.inserted_at!, locale: AppLocalizations.of(context)!.locale)}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${AppLocalizations.of(context)!.profileActivityTypeNotRecognzed} ${currentActivity.status}, ${AppLocalizations.of(context)!.profileType}: ${currentActivity.activity_type}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
