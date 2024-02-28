import 'package:flutter/material.dart';
import 'package:ministrar3/screens/home/help_requests.dart';
import 'package:ministrar3/screens/home/my_help_requests.dart';

class CustomeTabController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(text: 'Help Requests'),
            Tab(text: 'My HRs'),
          ],
        ),

        // Add a height constraint here
        body: TabBarView(
          children: [
            HelpRequests(),
            MyHelpRequests(),
          ],
        ),
      ),
    );
  }
}
