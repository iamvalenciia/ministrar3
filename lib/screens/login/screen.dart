import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custome_divider.dart';
import 'google_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor, zIndex: 2, name: 'login');
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName('login');
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    context.go('/');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/app_images/logo_light.png',
            height: 270,
          ),
          const SizedBox(height: 30),
          const CustomeDivider(),
          const SizedBox(height: 10),
          const SigninGoogleButton(),
        ],
      ),
    );
  }
}
