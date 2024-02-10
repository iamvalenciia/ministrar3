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

// NEXT STEP:
// 1. SAVE IMAGE URL FROM GOOGLE IN THE PROFILE TALBLE
// IMPLEMENT LOCATION
// IMPLEMENT 2 BUTTONS, FETCH 5 RANDOM POSTS, FETCH 5 POST CLOSE TO YOU
// 2. CREATE THE HOME PAGE DESIGN
// 3. IMPLEMENT RIVERPOD TO FETCH 5 POSTS WITH THE URL IMAGES,
// IMLPEMENT COMMMENT LOGIC
// IMPLEMENT CREATE REQUEST HLEP LOGIC
// IMPLEMENT GET LOCATION FROM MAP LAT AND LONG
// IMPLEMENT LOGC HELP -> THEN ASK FOR HELP -> THEN CREATE HELP REQUEST

// TESTING

// IMPLEMENT NOTIFICATION
// IMPLEMENT CHAT

// TESTING

// IMPLEMENT USER REPORT POSTS
// IMPLEMENT USER CAN BLOCK/UNBLOCK POST FROM OTHER USERS

// TESTING

// IMPLEMENT ADMIN TO SEE PEOPLE REPORTS
// IMPLEMENT ADMIN TO SEE PEOPLE BLOCKED
// IMPLEMENT ADMIN TO KICK USERS FROM THE APP

// TESTING

// CREATE A DATABASE FOR TESTING AND PRODUCTION WITH GITHUB ACTIONS
// IMPLEMENT TESTS
// IMPLEMENT CI/CD

// TESTING

// DEPLOY TO PLAY STORE

// TESTING MEMBERS OF THE CHURCH

// DEPLOY TO APPLE STORE
