import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart' as provider;

import 'app_routes.dart';
import 'main_screen.dart';
import 'provider/activity_provider.dart';
import 'provider/close_hrs_provider.dart';
import 'provider/conectivity_provider.dart';
import 'provider/help_points.dart';
import 'provider/km_mi_notifier.dart';
import 'provider/l10n_provider.dart';
import 'provider/loading_provider.dart';
import 'provider/location_permission.dart';
import 'provider/my_hr_provider.dart';
import 'provider/onboarding_provider.dart';
import 'provider/people_helping_provider.dart';
import 'provider/theme_provider.dart';
import 'provider/user_provider.dart';
import 'provider/user_ranking_provider.dart';
import 'services/supabase.dart';
import 'theme.dart';

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
        return MaterialApp(
          home: const MainScreen(),
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRoutes.generateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: provider.Provider.of<L10nNotifier>(context).appLocale,
          scaffoldMessengerKey: scaffoldKey,
          title: 'Ministrar',
          debugShowCheckedModeBanner: false,
          // theme: provider.Provider.of<ThemeProvider>(context).themeDataStyle);
          theme: ThemeDataStyle.light,
        );
      },
    );
  }
}

final providers = <SingleChildWidget>[
  provider.ChangeNotifierProvider(create: (_) => HelpRequestsNotifier()),
  // Async Network // Get db data
  provider.ChangeNotifierProvider(create: (_) => UserNotifier()),
  provider.ChangeNotifierProvider(create: (_) => MyHelpRequestNotifier()),
  provider.ChangeNotifierProvider(create: (_) => ActivityNotifier()),
  provider.ChangeNotifierProvider(create: (_) => LocationPermissionNotifier()),
  provider.ChangeNotifierProvider(create: (_) => PeopleHelpingNotifier()),
  //---------------------------------------------------------------------------
  //---------------------------------------------------------------------------
  provider.ChangeNotifierProvider(create: (_) => ThemeProvider()),
  provider.ChangeNotifierProvider(create: (_) => L10nNotifier()),
  provider.ChangeNotifierProvider(create: (_) => DistanceUnitNotifier()),
  provider.ChangeNotifierProvider(create: (_) => LoadingNotifier()),
  provider.ChangeNotifierProvider(create: (_) => OnboardingNavigation()),
  provider.ChangeNotifierProvider(create: (_) => UserRankingNotifier()),
  provider.ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
  provider.ChangeNotifierProvider(create: (_) => HelpPoints()),
];
