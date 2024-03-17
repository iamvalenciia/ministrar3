import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseScaffold extends StatelessWidget {
  final Widget? externalAppBarLeading;
  final Widget? externalAppBarTitle;
  final Widget? externalBody;
  final Widget? externalDrawer;

  const BaseScaffold({
    Key? key,
    this.externalBody,
    this.externalAppBarLeading,
    this.externalAppBarTitle,
    this.externalDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: externalAppBarTitle,
        leading: externalAppBarLeading,
      ),
      endDrawer: externalDrawer,
      body: externalBody,
    );
  }
}
