import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'help_requests.dart';
import 'my_help_request.dart';

class CustomeTabController extends StatelessWidget {
  const CustomeTabController({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: <Widget>[
            Tab(
              icon: const Icon(Icons.people),
              text: AppLocalizations.of(context)!.homeHelpRequests,
            ),
            Tab(
              icon: const Icon(Icons.person),
              text: AppLocalizations.of(context)!.homeMyHelpRequests,
            ),
          ],
        ),
        body: const TabBarView(
          children: <Widget>[
            HelpRequests(),
            MyHelpRequest(),
          ],
        ),
      ),
    );
  }
}
