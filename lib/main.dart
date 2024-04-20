import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart' as provider; // Import Provider

import 'go_router.dart';
import 'provider/activity_provider.dart';
import 'provider/close_hrs_provider.dart';
import 'provider/km_mi_notifier.dart';
import 'provider/location_permission.dart';
import 'provider/my_hr_provider.dart';
import 'provider/people_helping_provider.dart';
import 'provider/theme_provider.dart';
import 'provider/user_provider.dart';
import 'services/supabase.dart'; // Import ThemeNotifier

Future<void> main() async {
  await initializeSupabase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> scaffoldKey =
        GlobalKey<ScaffoldMessengerState>();
    return provider.MultiProvider(
      providers: providers,
      builder: (context, child) {
        return MaterialApp.router(
            scaffoldMessengerKey: scaffoldKey,
            title: 'Flutter Demo',
            routerConfig: goRouter,
            debugShowCheckedModeBanner: false,
            theme: provider.Provider.of<ThemeProvider>(context)
                .themeDataStyle // Add dark theme
            );
      },
    );
  }
}

// ------------------------------/
//  variable use in MyApp widget /
//-------------------------------/
final providers = <SingleChildWidget>[
  provider.ChangeNotifierProvider(create: (_) => HelpRequestsNotifier()),
  provider.ChangeNotifierProvider(create: (_) => UserNotifier()),
  provider.ChangeNotifierProvider(create: (_) => MyHelpRequestNotifier()),
  provider.ChangeNotifierProvider(create: (_) => ActivityNotifier()),
  provider.ChangeNotifierProvider(create: (_) => LocationPermissionNotifier()),
  provider.ChangeNotifierProvider(create: (_) => PeopleHelpingNotifier()),
  provider.ChangeNotifierProvider(create: (_) => DistanceUnitNotifier()),
  provider.ChangeNotifierProvider(create: (_) => ThemeProvider()),
];
