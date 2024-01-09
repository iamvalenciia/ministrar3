import 'package:flutter/material.dart';
import 'package:ministrar3/instances/supabase.dart';

class HelpRequests extends StatefulWidget {
  const HelpRequests({super.key});

  @override
  State<HelpRequests> createState() => _HelpRequestsState();
}

class _HelpRequestsState extends State<HelpRequests> {
  final Future<dynamic> _future = supabase.rpc('nearby_help_requests',
      params: {'lat': 0.817809, 'long': -79.685650});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: _future,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: Text((snapshot.data[index]['dist_kilometers']
                                .toDouble()
                                .toStringAsFixed(1)) +
                            ' km'),
                        subtitle: Text(snapshot.data[index]['content']),
                        trailing: Text(snapshot.data[index]['category']),
                      ),
                    );
                  });
            } else if (snapshot.error != null) {
              return Text('${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}
