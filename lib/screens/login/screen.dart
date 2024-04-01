import 'package:flutter/material.dart';
// import 'package:ministrar3/screens/login/app_description.dart';
import 'custome_divider.dart';
import 'google_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          // const SizedBox(height: 60),
          // const AppDescription(),
          const SizedBox(height: 30),
          const CustomeDivider(),
          const SizedBox(height: 10),
          const SigninGoogleButton(),
        ],
      ),
    );
  }
}
