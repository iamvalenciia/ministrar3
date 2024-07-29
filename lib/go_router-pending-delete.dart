// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// import 'badgets/mosaico.dart';
// import 'provider/activity_provider.dart';
// import 'provider/close_hrs_provider.dart';
// import 'provider/conectivity_provider.dart';
// import 'provider/location_permission.dart';
// import 'provider/my_hr_provider.dart';
// import 'provider/people_helping_provider.dart';
// import 'provider/user_provider.dart';
// import 'screens/form_help_request/screen.dart';
// import 'screens/form_username/screen.dart';
// import 'screens/help_request_for_helpers/screen.dart';
// import 'screens/help_request_for_owners/screen.dart';
// import 'screens/home/screen.dart';
// import 'screens/login-pending-delete/screen.dart';
// import 'screens/onboarding-pending-delete/screen.dart';
// import 'screens/profile/screen.dart';
// import 'screens/ranking-pending-delete/screen.dart';
// import 'screens/settings/screent.dart';
// import 'utility_functions.dart';

// final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> _shellNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'shell');

// final goRouter = GoRouter(
//   navigatorKey: _rootNavigatorKey,
//   initialLocation: '/',
//   debugLogDiagnostics: true,
//   routes: <RouteBase>[
//     ShellRoute(
//         builder: (BuildContext context, GoRouterState state, Widget child) {
//           return const BaseScaffold();
//         },
//         navigatorKey: _shellNavigatorKey,
//         routes: <RouteBase>[
//           Navigator.of(context).pushNamed(
//               routeSpecialScreen,
//               arguments: {'id': postId},
//             );
//           // GoRoute(
//           //   path: '/',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(child: const HomeScreenBody());
//           //   },
//           // ),
//           // GoRoute(
//           //   path: '/help-request-for-owners',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(child: HelpRequestForOwners());
//           //   },
//           // ),
//           // GoRoute(
//           //   path: '/help-request-for-helpers/:helpRequestUserId',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(
//           //       child: HelpRequestForHelpers(
//           //         helpRequestUserId: state.pathParameters['helpRequestUserId'],
//           //       ),
//           //     );
//           //   },
//           // ),
//           // GoRoute(
//           //   path: '/account',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(child: const ProfileScreen());
//           //   },
//           // ),
//           // GoRoute(
//           //   path: '/username-form',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(
//           //         child: const UsernameFormScreen());
//           //   },
//           // ),
//           // GoRoute(
//           //   path: '/login',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(child: const LoginScreen());
//           //   },
//           // ),
//           // GoRoute(
//           //   path: '/help-request-form',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(
//           //         child: const HelpRequestFormScreen());
//           //   },
//           // ),
//           // GoRoute(
//           //   path: '/settings',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(child: const SettingsScreen());
//           //   },
//           // ),
//           // GoRoute(
//           //   path: '/onboarding',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(
//           //         child: const OnboardingScreen());
//           //   },
//           // ),
//           // GoRoute(
//           //   path: '/ranking',
//           //   pageBuilder: (BuildContext context, GoRouterState state) {
//           //     return createCustomTransitionPage(child: const UserRakingList());
//           //   },
//           // ),
//         ]),
//   ],
// );

// // CustomTransitionPage<void> createCustomTransitionPage({
// //   required Widget child,
// // }) {
// //   return CustomTransitionPage<void>(
// //     child: child,
// //     transitionsBuilder: (BuildContext context, Animation<double> animation,
// //         Animation<double> secondaryAnimation, Widget child) {
// //       return FadeTransition(
// //         opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
// //         child: child,
// //       );
// //     },
// //   );
// // }

// // ------------------------------/
// //  widget used in the go_router /
// //-------------------------------/
// // class CustomeNavigationDrawer extends StatelessWidget {
// //   const CustomeNavigationDrawer({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final user = context.read<UserNotifier>();
// //     final activityNotifier = context.read<ActivityNotifier>();
// //     final peopleHelpingNotifier = context.read<PeopleHelpingNotifier>();
// //     final ConnectivityProvider connectivityStatus =
// //         Provider.of<ConnectivityProvider>(context, listen: false);

// //     return NavigationDrawer(
// //       children: <Widget>[
// //         DrawerHeader(
// //           decoration: BoxDecoration(
// //             color: Theme.of(context).colorScheme.surface,
// //           ),
// //           child: const Text(''),
// //         ),
// //         Selector<UserNotifier, bool>(
// //           selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
// //           builder: (_, userExist, __) => ListTile(
// //             enabled: userExist &&
// //                 connectivityStatus.status != ConnectivityStatus.Offline,
// //             selectedColor: Theme.of(context).colorScheme.primary,
// //             title: Text(AppLocalizations.of(context)!.profile),
// //             leading: const Icon(Icons.account_circle),
// //             onTap: () {
// //               Navigator.pop(context);
// //               context.go('/account');
// //             },
// //           ),
// //         ),
// //         // add a donation buttoN
// //         // ListTile(
// //         //   selectedColor: Theme.of(context).colorScheme.primary,
// //         //   title: Text(AppLocalizations.of(context)!.donation),
// //         //   leading: const Icon(Icons.monetization_on),
// //         //   onTap: () {
// //         //     Navigator.pop(context);
// //         //     context.go('/donation');
// //         //   },
// //         // ),
// //         Selector<UserNotifier, bool>(
// //           selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
// //           builder: (_, userExist, __) => ListTile(
// //             enabled: userExist &&
// //                 connectivityStatus.status != ConnectivityStatus.Offline,
// //             selectedColor: Theme.of(context).colorScheme.primary,
// //             title: Text(AppLocalizations.of(context)!.rankingTitle),
// //             leading: const Icon(Icons.leaderboard),
// //             onTap: () {
// //               Navigator.pop(context);
// //               context.go('/ranking');
// //             },
// //           ),
// //         ),
// //         Selector<LocationPermissionNotifier, bool>(
// //           selector: (_, locationPermissionNotifier) =>
// //               locationPermissionNotifier.hasLocationPermission,
// //           builder: (_, hasLocationPermission, __) => ListTile(
// //             enabled: hasLocationPermission,
// //             selectedColor: Theme.of(context).colorScheme.primary,
// //             title: Text(AppLocalizations.of(context)!.settings),
// //             leading: const Icon(Icons.settings),
// //             onTap: () {
// //               if (hasLocationPermission) {
// //                 Navigator.pop(context);
// //                 context.go('/settings');
// //               }
// //             },
// //           ),
// //         ),
// //         ListTile(
// //           selectedColor: Theme.of(context).colorScheme.primary,
// //           title: Text(AppLocalizations.of(context)!.guide),
// //           // onboarding icon
// //           leading: const Icon(Icons.info),
// //           onTap: () {
// //             Navigator.pop(context);
// //             context.go('/onboarding');
// //           },
// //         ),
// //         Selector<UserNotifier, bool>(
// //           selector: (_, userNotifier) => userNotifier.isUserLoggedIn,
// //           builder: (_, userExist, __) => ListTile(
// //             enabled: userExist &&
// //                 connectivityStatus.status != ConnectivityStatus.Offline,
// //             title: Text(AppLocalizations.of(context)!.logout),
// //             leading: const Icon(Icons.logout),
// //             onTap: () async {
// //               final navigateTo = GoRouter.of(context);
// //               final popFunction = Navigator.of(context).pop;
// //               final messenger = ScaffoldMessenger.of(context);
// //               final color = Theme.of(context);
// //               try {
// //                 activityNotifier.clearIsHelping();
// //                 activityNotifier.clearHelpActivities();
// //                 activityNotifier.clearLastFourActivities();
// //                 peopleHelpingNotifier.clearPeopleHelping();
// //                 await user.logOut();
// //                 user.updateLoginStatus();
// //                 // Await the logout operation

// //                 navigateTo.go('/login');
// //                 popFunction();

// //                 Geolocator.checkPermission().then((value) async {
// //                   if (value == LocationPermission.whileInUse ||
// //                       value == LocationPermission.always) {
// //                     final helpRequestsNotifier =
// //                         context.read<HelpRequestsNotifier>();
// //                     final myHelpRequestNotifier =
// //                         context.read<MyHelpRequestNotifier>();
// //                     myHelpRequestNotifier.clearHelpRequest();
// //                     await helpRequestsNotifier.fetchHelpRequests();
// //                   }
// //                 });
// //               } catch (e) {
// //                 messenger.showSnackBar(
// //                   SnackBar(
// //                     backgroundColor: color.colorScheme.error,
// //                     content: Text(e.toString()),
// //                   ),
// //                 );
// //               }
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // ------------------------------/
// //  widget used in the go_router /
// //-------------------------------/
// class BaseScaffold extends StatefulWidget {
//   const BaseScaffold({super.key // Add this line
//       });

//   @override
//   State<BaseScaffold> createState() => _BaseScaffoldState();
// }

// class _BaseScaffoldState extends State<BaseScaffold> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     const List<Widget> widgetOptions = <Widget>[
//       Text(
//         'Index 0: Home',
//       ),
//       Text(
//         'Index 1: Business',
//       ),
//       Text(
//         'Index 2: School',
//       ),
//       Text(
//         'Index 3: Settings',
//       ),
//     ];

//     final List<AppBar> appBarOptions = <AppBar>[
//       AppBar(
//         title: Text('Home'),
//         leading: Icon(Icons.home),
//       ),
//       AppBar(
//         title: Text('Business'),
//         leading: Icon(Icons.business),
//       ),
//       AppBar(
//         title: Text('School'),
//         leading: Icon(Icons.school),
//       ),
//       AppBar(
//         title: Text('Settings'),
//         leading: Icon(Icons.settings),
//       ),
//     ];

//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Inicio',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.help),
//             label: 'Ayuda',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: AppLocalizations.of(context)!.profile,
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Theme.of(context).colorScheme.primary,
//         onTap: _onItemTapped,
//       ),
//       appBar: appBarOptions[_selectedIndex],
//       // endDrawer: externalDrawer,
//       body: Center(
//         child: widgetOptions.elementAt(_selectedIndex),
//       ),
//     );
//   }
// }
