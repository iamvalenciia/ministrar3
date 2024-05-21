import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/activity_provider.dart';
import 'provider/close_hrs_provider.dart';
import 'provider/location_permission.dart';
import 'provider/my_hr_provider.dart';
import 'provider/people_helping_provider.dart';
import 'provider/user_provider.dart';
import 'screens/form_help_request/screen.dart';
import 'screens/form_username/screen.dart';
import 'screens/help_request_for_helpers/screen.dart';
import 'screens/help_request_for_owners/screen.dart';
import 'screens/home/screen.dart';
import 'screens/login/screen.dart';
import 'screens/onboarding/screen.dart';
import 'screens/profile/screen.dart';
import 'screens/settings/screent.dart';
import 'utility_functions.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final isNotHome = state.fullPath != '/';
          String appBarTitle = '';
          if (state.fullPath ==
              '/help-request-for-helpers/:helpRequestUserId') {
            appBarTitle = AppLocalizations.of(context)!.helperHelpRequest;
          } else if (state.fullPath == '/help-request-for-owners') {
            appBarTitle = AppLocalizations.of(context)!.ownerMyHelpRequest;
          } else if (state.fullPath == '/') {
            appBarTitle = 'Ministrar';
          } else if (state.fullPath == '/login') {
            appBarTitle = AppLocalizations.of(context)!.loginSignIn;
          } else if (state.fullPath == '/account') {
            appBarTitle = AppLocalizations.of(context)!.profile;
          } else if (state.fullPath == '/username-form') {
            appBarTitle = AppLocalizations.of(context)!.usernameSetup;
          } else if (state.fullPath == '/help-request-form') {
            appBarTitle = AppLocalizations.of(context)!.createHelpRequest;
          } else if (state.fullPath == '/settings') {
            appBarTitle = AppLocalizations.of(context)!.settings;
          } else if (state.fullPath == '/onboarding') {
            return const OnboardingScreen();
          }
          return BaseScaffold(
            externalBody: child,
            externalAppBarLeading: state.fullPath == '/username-form'
                ? IconButton(
                    onPressed: () async {
                      try {
                        final user = context.read<UserNotifier>();
                        final username = user.user?.username;

                        if (username != null) {
                          context.go('/account');
                        } else {
                          context.go('/login');
                          await user.logOut();
                          user.updateLoginStatus();
                        }
                      } catch (e) {
                        // Check for mounted state before UI interactions
                        if (!context.mounted) {
                          return;
                        }
                        showFlashError(context,
                            'Error - Arrow Icon from username form: $e');
                      }
                    },
                    icon: const Icon(Icons.arrow_back),
                  )
                : state.fullPath == '/onboarding'
                    ? null
                    : isNotHome
                        ? IconButton(
                            onPressed: () => context.go('/'),
                            icon: const Icon(Icons.arrow_back))
                        : null,
            externalAppBarTitle: Text(appBarTitle),
            externalDrawer:
                state.fullPath == '/' ? const CustomeNavigationDrawer() : null,
          );
        },
        navigatorKey: _shellNavigatorKey,
        routes: <RouteBase>[
          createGoRoute(
            path: '/',
            childBuilder: (state) => const HomeScreenBody(),
          ),
          createGoRoute(
            path: '/help-request-for-owners',
            childBuilder: (state) => HelpRequestForOwners(),
          ),
          createGoRoute(
            path: '/help-request-for-helpers/:helpRequestUserId',
            childBuilder: (state) => HelpRequestForHelpers(
              helpRequestUserId: state.pathParameters['helpRequestUserId'],
            ),
          ),
          createGoRoute(
            path: '/account',
            childBuilder: (state) => const ProfileScreen(),
          ),
          createGoRoute(
            path: '/username-form',
            childBuilder: (state) => const UsernameFormScreen(),
          ),
          createGoRoute(
            path: '/login',
            childBuilder: (state) => const LoginScreen(),
          ),
          createGoRoute(
            path: '/help-request-form',
            childBuilder: (state) => const HelpRequestFormScreen(),
          ),
          createGoRoute(
            path: '/settings',
            childBuilder: (state) => const SettingsScreen(),
          ),
          createGoRoute(
            path: '/onboarding',
            childBuilder: (state) => const OnboardingScreen(),
          ),
          // GoRoute(
          //   path: '/onboarding',
          //   pageBuilder: (BuildContext context, GoRouterState state) {
          //     return const MaterialPage(child: OnboardingScreen());
          //   },
          // ),
        ]),
  ],
);

// ------------------------------/
//  widget used in the go_router /
//-------------------------------/
GoRoute createGoRoute({
  required String path,
  required Widget Function(GoRouterState state) childBuilder,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return createCustomTransitionPage(child: childBuilder(state));
    },
  );
}

// ------------------------------/
//  widget used in the go_router /
//-------------------------------/
CustomTransitionPage<void> createCustomTransitionPage({
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    child: child,
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}

// ------------------------------/
//  widget used in the go_router /
//-------------------------------/
class CustomeNavigationDrawer extends StatelessWidget {
  const CustomeNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserNotifier>();
    final activityNotifier = context.read<ActivityNotifier>();
    final peopleHelpingNotifier = context.read<PeopleHelpingNotifier>();

    return NavigationDrawer(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: const Text(''),
        ),
        Selector<UserNotifier, bool>(
          selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
          builder: (_, userExist, __) => ListTile(
            enabled: userExist,
            selectedColor: Theme.of(context).colorScheme.primary,
            title: Text(AppLocalizations.of(context)!.profile),
            leading: const Icon(Icons.account_circle),
            onTap: () {
              Navigator.pop(context);
              context.go('/account');
            },
          ),
        ),
        Selector<LocationPermissionNotifier, bool>(
          selector: (_, locationPermissionNotifier) =>
              locationPermissionNotifier.hasLocationPermission,
          builder: (_, hasLocationPermission, __) => ListTile(
            enabled: hasLocationPermission,
            selectedColor: Theme.of(context).colorScheme.primary,
            title: Text(AppLocalizations.of(context)!.settings),
            leading: const Icon(Icons.settings),
            onTap: () {
              if (hasLocationPermission) {
                Navigator.pop(context);
                context.go('/settings');
              }
            },
          ),
        ),
        ListTile(
          selectedColor: Theme.of(context).colorScheme.primary,
          title: Text(AppLocalizations.of(context)!.guide),
          // onboarding icon
          leading: const Icon(Icons.info),
          onTap: () {
            Navigator.pop(context);
            context.go('/onboarding');
          },
        ),
        Selector<UserNotifier, bool>(
          selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
          builder: (_, userExist, __) => ListTile(
            enabled: userExist,
            title: Text(AppLocalizations.of(context)!.logout),
            leading: const Icon(Icons.logout),
            onTap: () async {
              final navigateTo = GoRouter.of(context);
              final popFunction = Navigator.of(context).pop;
              final messenger = ScaffoldMessenger.of(context);
              final color = Theme.of(context);
              try {
                activityNotifier.clearIsHelping();
                activityNotifier.clearHelpActivities();
                activityNotifier.clearLastFourActivities();
                peopleHelpingNotifier.clearPeopleHelping();
                await user.logOut();
                user.updateLoginStatus();
                // Await the logout operation

                navigateTo.go('/login');
                popFunction();

                Geolocator.checkPermission().then((value) async {
                  if (value == LocationPermission.whileInUse ||
                      value == LocationPermission.always) {
                    final helpRequestsNotifier =
                        context.read<HelpRequestsNotifier>();
                    final myHelpRequestNotifier =
                        context.read<MyHelpRequestNotifier>();
                    myHelpRequestNotifier.clearHelpRequest();
                    await helpRequestsNotifier.fetchHelpRequests();
                  }
                });
              } catch (e) {
                messenger.showSnackBar(
                  SnackBar(
                    backgroundColor: color.colorScheme.error,
                    content: Text(e.toString()),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

// ------------------------------/
//  widget used in the go_router /
//-------------------------------/
class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.externalBody,
    this.externalAppBarLeading,
    this.externalAppBarTitle,
    this.externalDrawer,
  });

  final Widget? externalAppBarLeading;
  final Widget? externalAppBarTitle;
  final Widget? externalBody;
  final Widget? externalDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: externalAppBarTitle,
        leading: externalAppBarLeading,
      ),
      endDrawer: externalDrawer,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: externalBody,
      ),
    );
  }
}
