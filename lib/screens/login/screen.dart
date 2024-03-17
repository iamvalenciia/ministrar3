import 'package:flutter/material.dart';
// import 'package:ministrar3/screens/login/app_description.dart';
import 'package:ministrar3/screens/login/custome_divider.dart';
import 'package:ministrar3/screens/login/google_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/app_images/logo_light.png',
              height: 290,
            ),
            // const SizedBox(height: 60),
            // const AppDescription(),
            const SizedBox(height: 80),
            const CustomeDivider(),
            const SizedBox(height: 10),
            const SigninGoogleButton(),
          ],
        ),
      ),
    );
  }
}
