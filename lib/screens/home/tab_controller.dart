import 'package:flutter/material.dart';

import 'tab_help_requests.dart';
import 'tab_my_help_request.dart';

class CustomeTabController extends StatelessWidget {
  const CustomeTabController({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.people),
              text: 'Help Requests',
            ),
            Tab(
              icon: Icon(Icons.person),
              text: 'My Help Request',
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            HelpRequests(),
            MyHelpRequest(),
          ],
        ),
      ),
    );
  }
}
