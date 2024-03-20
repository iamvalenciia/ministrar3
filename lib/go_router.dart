import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:ministrar3/provider/user_provider.dart';
import 'package:ministrar3/screens/form_edit_help_request/screen.dart';
import 'package:ministrar3/screens/home/screen.dart';
import 'package:ministrar3/utility/navigation_drawer.dart';
import 'package:ministrar3/utility/base_scaffold.dart';
import 'package:ministrar3/screens/form_create_help_request/screen.dart';
import 'package:ministrar3/screens/help_request/screen.dart';
import 'package:ministrar3/screens/profile/screen.dart';
import 'package:ministrar3/screens/login/screen.dart';
import 'package:ministrar3/screens/form_username/screen.dart';
import 'package:ministrar3/services/google.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

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
          final user = context.watch<UserNotifier>().userData;
          final isNotHome = state.fullPath != '/home';
          String appBarTitle = '';
          if (state.fullPath!.startsWith('/home/help-request-details')) {
            final helpRequestUserId = state.pathParameters['helpRequestUserId'];

            final userId = supabase.auth.currentUser?.id;
            final helpRequestsNotifier = context.watch<HelpRequestsNotifier>();
            final myHelpRequestNotifier =
                context.watch<MyHelpRequestNotifier>();

            developer.log('helpRequestId: $helpRequestUserId');

            final helpRequest = userId == helpRequestUserId
                ? myHelpRequestNotifier.myHelpRequest
                : helpRequestsNotifier.helpRequests
                    ?.firstWhere((r) => r.user_id == helpRequestUserId);
            appBarTitle = '${helpRequest?.category}';
          } else {
            switch (state.fullPath) {
              case '/home':
                appBarTitle = 'Ministrar';
                break;
              case '/home/login':
                appBarTitle = 'Sign In';
                break;
              case '/home/account':
                appBarTitle = 'Profile';
                break;
              case '/home/account/username-form':
                appBarTitle = 'Setup your Username';
                break;
              case '/home/help-request-form':
                appBarTitle = 'Create Help Request';
                break;
              case '/home/help-request-details/:helpRequestUserId':
                appBarTitle = 'Help Request Details';
                break;
              case '/home/edit-help-request':
                appBarTitle = 'Edit Help Request';
                break;
              default:
                appBarTitle = '';
            }
          }
          return BaseScaffold(
            externalBody: child,
            externalAppBarLeading:
                state.fullPath == '/home/account/username-form'
                    ? IconButton(
                        onPressed: () async {
                          if (user?.username != null) {
                            context.go('/home/account');
                          } else {
                            context.go('/home/login');
                            final GoogleSignIn googleSignIn =
                                await GoogleProvider.getGoogleSignIn();
                            await supabase.auth.signOut();
                            await googleSignIn.signOut();
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
            externalDrawer: state.fullPath == '/home/account/username-form' ||
                    state.fullPath == '/home/help-request-form' ||
                    state.fullPath!.startsWith('/home/help-request-details')
                ? null
                : CustomeNavigationDrawer(),
          );
        },
        navigatorKey: _shellNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            path: '/home',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: HomeScreenBody(),
                transitionDuration: const Duration(milliseconds: 150),
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  // Change the opacity of the screen using a Curve based on the the animation's
                  // value
                  return FadeTransition(
                    opacity:
                        CurveTween(curve: Curves.easeInOut).animate(animation),
                    child: child,
                  );
                },
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'help-request-details/:helpRequestUserId',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: HelpRequestDetails(
                      helpRequestUserId:
                          state.pathParameters['helpRequestUserId'],
                    ),
                    transitionDuration: const Duration(milliseconds: 150),
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      // Change the opacity of the screen using a Curve based on the the animation's
                      // value
                      return FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOut)
                            .animate(animation),
                        child: child,
                      );
                    },
                  );
                },
              ),
              GoRoute(
                  path: 'account',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: ProfileScreen(),
                      transitionDuration: const Duration(milliseconds: 150),
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        // Change the opacity of the screen using a Curve based on the the animation's
                        // value
                        return FadeTransition(
                          opacity: CurveTween(curve: Curves.easeInOut)
                              .animate(animation),
                          child: child,
                        );
                      },
                    );
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'username-form',
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: UsernameFormScreen(),
                          transitionDuration: const Duration(milliseconds: 150),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            // Change the opacity of the screen using a Curve based on the the animation's
                            // value
                            return FadeTransition(
                              opacity: CurveTween(curve: Curves.easeInOut)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        );
                      },
                    ),
                  ]),
              GoRoute(
                path: 'login',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: LoginScreen(),
                    transitionDuration: const Duration(milliseconds: 50),
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      // Change the opacity of the screen using a Curve based on the the animation's
                      // value
                      return FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOut)
                            .animate(animation),
                        child: child,
                      );
                    },
                  );
                },
              ),
              GoRoute(
                path: 'edit-help-request',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: EditHelpRequest(),
                    transitionDuration: const Duration(milliseconds: 150),
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      // Change the opacity of the screen using a Curve based on the the animation's
                      // value
                      return FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOut)
                            .animate(animation),
                        child: child,
                      );
                    },
                  );
                },
              ),
              GoRoute(
                path: 'help-request-form',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: HelpRequestFormScreen(),
                    transitionDuration: const Duration(milliseconds: 150),
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      // Change the opacity of the screen using a Curve based on the the animation's
                      // value
                      return FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOut)
                            .animate(animation),
                        child: child,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ])
  ],
);
