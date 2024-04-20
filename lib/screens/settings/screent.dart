import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/close_hrs_provider.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/theme_provider.dart';
import '../../theme.dart'; // Import your HelpRequestsNotifier

enum DistanceUnit { kilometers, miles }

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<HelpRequestsNotifier, ThemeProvider>(
        builder: (context, helpRequestsNotifier, themeProvider, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Column(
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
                  const SizedBox(height: 20),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Row(
                      children: [
                        Text('Theme Style',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ThemeChoice(themeProvider: themeProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// -------------------------------------------/
//  widget used in the SettingsScreen widget /
//-------------------------------------------/
class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key, required this.helpRequestsNotifier});
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
    final MyHelpRequestNotifier myHelpRequestNotifier =
        context.read<MyHelpRequestNotifier>();
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
                myHelpRequestNotifier.switchDistanceUnit();
              });
            },
          ),
        ),
      ],
    );
  }
}

// -------------------------------------------/
//  widget used in the SettingsScreen widget /
//-------------------------------------------/
enum ThemeStyle { light, dark }

class ThemeChoice extends StatefulWidget {
  const ThemeChoice({super.key, required this.themeProvider});
  final ThemeProvider themeProvider;

  @override
  State<ThemeChoice> createState() => _ThemeChoiceState();
}

class _ThemeChoiceState extends State<ThemeChoice> {
  late ThemeStyle themeStyle;

  @override
  void initState() {
    super.initState();
    themeStyle = widget.themeProvider.themeDataStyle == ThemeDataStyle.light
        ? ThemeStyle.light
        : ThemeStyle.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SegmentedButton<ThemeStyle>(
            segments: const <ButtonSegment<ThemeStyle>>[
              ButtonSegment<ThemeStyle>(
                  value: ThemeStyle.light, label: Text('Light')),
              ButtonSegment<ThemeStyle>(
                  value: ThemeStyle.dark, label: Text('Dark')),
            ],
            selected: <ThemeStyle>{themeStyle},
            onSelectionChanged: (Set<ThemeStyle> newSelection) {
              setState(() {
                themeStyle = newSelection.first;
                widget.themeProvider.changeTheme();
              });
            },
          ),
        ),
      ],
    );
  }
}
