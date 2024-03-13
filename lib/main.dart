import 'package:flutter/material.dart';
import 'package:ministrar3/models/help_requests_model/help_request_model.dart';
import 'package:ministrar3/provider/activity_provider.dart';
import 'package:ministrar3/provider/close_hrs_provider.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:ministrar3/provider/user_provider.dart';
import 'package:ministrar3/screens/form_help_request/screen.dart';
import 'package:ministrar3/screens/home/help_request_details.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:ministrar3/screens/my_profile/screen.dart';
import 'package:ministrar3/screens/home/screen.dart';
import 'package:ministrar3/screens/login/screen.dart';
import 'package:ministrar3/screens/form_username/screen.dart';
// import 'package:ministrar3/pages/setup_username_page.dart';
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
      ],
      child: MaterialApp(
        scaffoldMessengerKey: _scaffoldKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal, brightness: Brightness.light),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w200,
            ),
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/account': (context) => ProfileScreen(),
          '/username-form': (context) => UsernameFormScreen(),
          '/help-request-form': (context) => HelpRequestFormScreen(),
          '/help-request-details': (context) => HelpRequestDetails(
                request: ModalRoute.of(context)!.settings.arguments
                    as HelpRequestModel,
                onBack: () {
                  Navigator.of(context).pop();
                },
              ),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
