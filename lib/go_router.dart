import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'provider/close_hrs_provider.dart';
import 'provider/my_hr_provider.dart';
import 'provider/user_provider.dart';
import 'screens/form_create_help_request/screen.dart';
import 'screens/form_edit_help_request/screen.dart';
import 'screens/form_username/screen.dart';
import 'screens/help_request_details/screen.dart';
import 'screens/home/screen.dart';
import 'screens/login/screen.dart';
import 'screens/profile/screen.dart';
import 'services/google.dart';
import 'services/supabase.dart';
import 'utility_functions.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final isNotHome = state.fullPath != '/home';
          String appBarTitle = '';
          if (state.fullPath == '/help-request-details/:helpRequestUserId') {
            final helpRequestUserId = state.pathParameters['helpRequestUserId'];
            final userId = supabase.auth.currentUser?.id;
            final helpRequestsNotifier = context.read<HelpRequestsNotifier>();
            final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
            developer.log('helpRequestId: $helpRequestUserId');
            final helpRequest = userId == helpRequestUserId
                ? myHelpRequestNotifier.myHelpRequest
                : helpRequestsNotifier.helpRequests
                    ?.firstWhere((r) => r.user_id == helpRequestUserId);
            appBarTitle = '${helpRequest?.category}';
          } else if (state.fullPath == '/home') {
            appBarTitle = 'Ministrar';
          } else if (state.fullPath == '/login') {
            appBarTitle = 'Sign In';
          } else if (state.fullPath == '/account') {
            appBarTitle = 'Profile';
          } else if (state.fullPath == '/username-form') {
            appBarTitle = 'Setup your Username';
          } else if (state.fullPath == '/help-request-form') {
            appBarTitle = 'Create Help Request';
          } else if (state.fullPath == '/edit-help-request') {
            appBarTitle = 'Edit Help Request';
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
                          final GoogleSignIn googleSignIn =
                              await GoogleProvider.getGoogleSignIn();
                          user.logout();
                          await googleSignIn.signOut();
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
                : isNotHome
                    ? IconButton(
                        onPressed: () => context.go('/home'),
                        icon: const Icon(Icons.arrow_back))
                    : null,
            externalAppBarTitle: Text(appBarTitle),
            externalDrawer: state.fullPath == '/home'
                ? const CustomeNavigationDrawer()
                : null,
          );
        },
        navigatorKey: _shellNavigatorKey,
        routes: <RouteBase>[
          createGoRoute(
            path: '/home',
            childBuilder: (state) => const HomeScreenBody(),
          ),
          createGoRoute(
            path: '/help-request-details/:helpRequestUserId',
            childBuilder: (state) => HelpRequestDetails(
              helpRequestUserId: state.pathParameters['helpRequestUserId'],
              index: int.tryParse(state.pathParameters['index'] ?? '0') ?? 0,
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
            path: '/edit-help-request',
            childBuilder: (state) => const EditHelpRequest(),
          ),
          createGoRoute(
            path: '/help-request-form',
            childBuilder: (state) => const HelpRequestFormScreen(),
          ),
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
    return NavigationDrawer(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: const Text('Drawer Header'),
        ),
        Selector<UserNotifier, bool>(
          selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
          builder: (_, userExist, __) => ListTile(
            enabled: userExist,
            selectedColor: Theme.of(context).colorScheme.primary,
            title: const Text('Profile'),
            leading: const Icon(Icons.account_circle),
            onTap: () {
              Navigator.pop(context);
              context.go('/account');
            },
          ),
        ),
        Selector<UserNotifier, bool>(
          selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
          builder: (_, userExist, __) => ListTile(
            enabled: userExist,
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              try {
                final googleService = await GoogleProvider.getGoogleSignIn();
                await Future.wait([
                  user.logout(),
                  googleService.signOut(),
                ]).then((value) {
                  Navigator.pop(context);
                  context.go('/login');
                  checkPermissionsAndFetchRequests(context);
                });
              } catch (e) {
                // Check for mounted state before UI interactions
                if (!context.mounted) {
                  return;
                }
                showFlashError(context, 'Error - Logout Button: $e');
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
