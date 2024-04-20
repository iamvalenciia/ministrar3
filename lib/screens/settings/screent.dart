import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/close_hrs_provider.dart'; // Import your HelpRequestsNotifier

enum DistanceUnit { kilometers, miles }

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HelpRequestsNotifier>(
        builder: (context, helpRequestsNotifier, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(
                    children: [
                      Text('Distance Unit',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SingleChoice(helpRequestsNotifier: helpRequestsNotifier),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SingleChoice extends StatefulWidget {
  const SingleChoice({Key? key, required this.helpRequestsNotifier})
      : super(key: key);
  final HelpRequestsNotifier helpRequestsNotifier;

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  late DistanceUnit distanceUnit;

  @override
  void initState() {
    super.initState();
    distanceUnit = widget.helpRequestsNotifier.isDistanceInKilometers
        ? DistanceUnit.kilometers
        : DistanceUnit.miles;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SegmentedButton<DistanceUnit>(
            segments: const <ButtonSegment<DistanceUnit>>[
              ButtonSegment<DistanceUnit>(
                  value: DistanceUnit.kilometers, label: Text('Kilometers')),
              ButtonSegment<DistanceUnit>(
                  value: DistanceUnit.miles, label: Text('Miles')),
            ],
            selected: <DistanceUnit>{distanceUnit},
            onSelectionChanged: (Set<DistanceUnit> newSelection) {
              setState(() {
                distanceUnit = newSelection.first;
                widget.helpRequestsNotifier.switchDistanceUnit();
              });
            },
          ),
        ),
      ],
    );
  }
}
