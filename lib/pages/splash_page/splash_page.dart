import 'package:flutter/material.dart';
import 'package:ministrar3/instances/supabase.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // thse are the change we gonna make:
    // 1. Directly render the home page, no mmater user login
    // 2. show a badget at the top of the screen saying: you need an account if you want
    // to interact with the app
    // 3 if the user is not login, many liminatation: cant comment, cant press button to help, can't navigate to profile
    // the unique thing the user can loggin is click in the badget so send to onboarding screen to login with google, apple.
    // after login with google check if user already exist, if exist with their id sen to home, if not, send the user to
    // create account, insert username, full name.
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      Navigator.of(context).pushReplacementNamed('/account');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
