import 'package:flutter/material.dart';
// import 'package:ministrar3/models/help_requests_model/help_request_model.dart';
import 'package:ministrar3/screens/home/5_help_requests.dart';
import 'package:ministrar3/screens/home/my_help_request.dart';

class CustomeTabController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(
              text: 'Help Requests',
            ),
            Tab(
              text: 'Me',
            ),
          ],
        ),
        body: TabBarView(
          children: [
            HelpRequestsScreen(),
            MyHelpRequests(),
          ],
        ),
      ),
    );
  }
}
