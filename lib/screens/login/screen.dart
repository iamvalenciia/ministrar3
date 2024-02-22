import 'package:flutter/material.dart';
import 'package:ministrar3/screens/login/app_description.dart';
import 'package:ministrar3/screens/login/custome_divider.dart';
import 'package:ministrar3/screens/login/riverpod_signin_google_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/app_images/logo_light.png',
            height: 290,
          ),
          const SizedBox(height: 60),
          const AppDescription(),
          const SizedBox(height: 60),
          const CustomeDivider(),
          const SizedBox(height: 30),
          const SigninGoogleButton(),
        ],
      ),
    );
  }
}
