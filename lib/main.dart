import 'package:flutter/material.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:ministrar3/screens/profile/screen.dart';
import 'package:ministrar3/screens/home/screen.dart';
import 'package:ministrar3/screens/login/screen.dart';
import 'package:ministrar3/screens/username/screen.dart';
// import 'package:ministrar3/pages/setup_username_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await initializeSupabase();
  runApp(const ProviderScope(child: MyApp()));
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
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
        '/setup-username': (context) => const UsernameScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
