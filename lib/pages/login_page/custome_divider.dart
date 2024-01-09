import 'package:flutter/material.dart';

class CustomeDivider extends StatefulWidget {
  const CustomeDivider({super.key});

  @override
  State<CustomeDivider> createState() => _CustomeDividerState();
}

class _CustomeDividerState extends State<CustomeDivider> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Login or create an account",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
