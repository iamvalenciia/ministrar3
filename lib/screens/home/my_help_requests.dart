import 'package:flutter/material.dart';
import 'package:ministrar3/models/help_requests_model/help_request_model.dart';
import 'package:ministrar3/provider/my_hr_provider.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:provider/provider.dart';

class MyHelpRequests extends StatelessWidget {
  final void Function(HelpRequestModel) onSelect;

  MyHelpRequests({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final userExist = supabase.auth.currentUser?.id != null;
    final myHelpRequestsNotifier = context.watch<MyHelpRequestNotifier>();
    final myHelpRequest = myHelpRequestsNotifier.myHelpRequest;

    if (myHelpRequest == null) {
      return CircularProgressIndicator(); // Show a loading indicator
    } else if (myHelpRequest != null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, index) {
          final request = myHelpRequest;
          return Card(
            child: Container(
              width: 300, // Set a finite width here
              child: ListTile(
                leading: const Icon(Icons.account_circle),
                title: Text(request.username.toString()),
                subtitle: Text(
                    '${request.distance?.toInt() ?? 'Calculating...'} m'), // Replace with actual distance logic
                trailing: Text(request.category.toString()),
                onTap: () {
                  onSelect(request);
                },
              ),
            ),
          );
        },
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 50),
        child: ElevatedButton(
          onPressed: userExist
              ? () => Navigator.of(context)
                  .pushReplacementNamed('/help-request-form')
              : null,
          child: Row(
            children: [
              const Icon(Icons.post_add),
              SizedBox(width: 10),
              const Text('Create a Help Request'),
            ],
          ),
        ),
      );
    }
  }
}
