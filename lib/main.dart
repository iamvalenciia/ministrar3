import 'package:flutter/material.dart';
import 'package:ministrar3/provider/activity_provider.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:ministrar3/provider/permission_provider.dart';
import 'package:ministrar3/provider/user_provider.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:ministrar3/go_router.dart';
import 'package:provider/provider.dart' as provider; // Import Provider

Future<void> main() async {
  await initializeSupabase();
  runApp(MyApp());
}

//
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (_) => HelpRequestsNotifier()),
        provider.ChangeNotifierProvider(create: (_) => UserNotifier()),
        provider.ChangeNotifierProvider(create: (_) => MyHelpRequestNotifier()),
        provider.ChangeNotifierProvider(create: (_) => ActivityNotifier()),
        provider.ChangeNotifierProvider(create: (_) => PermissionProvider()),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: _scaffoldKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal, brightness: Brightness.dark),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w200,
            ),
          ),
          useMaterial3: true,
        ),
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
