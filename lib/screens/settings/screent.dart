import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/close_hrs_provider.dart';
import '../../provider/l10n_provider.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/theme_provider.dart';
import '../../theme.dart'; // Import your HelpRequestsNotifier

enum DistanceUnit { kilometers, miles }

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer3<HelpRequestsNotifier, ThemeProvider, L10nNotifier>(
        builder: (context, helpRequestsNotifier, themeProvider, l10nNotifier,
            child) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context)!.settingsDistanceUnit,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SingleChoice(helpRequestsNotifier: helpRequestsNotifier),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context)!.settingsThemeStyle,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ThemeChoice(themeProvider: themeProvider),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context)!.settingsLanguage,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  LanguageChoice(l10nNotifier: l10nNotifier),
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
            segments: <ButtonSegment<DistanceUnit>>[
              ButtonSegment<DistanceUnit>(
                  value: DistanceUnit.kilometers,
                  label:
                      Text(AppLocalizations.of(context)!.settingsKilometers)),
              ButtonSegment<DistanceUnit>(
                  value: DistanceUnit.miles,
                  label: Text(AppLocalizations.of(context)!.settingsMiles)),
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
            segments: <ButtonSegment<ThemeStyle>>[
              ButtonSegment<ThemeStyle>(
                  value: ThemeStyle.light,
                  label: Text(AppLocalizations.of(context)!.settingsLight)),
              ButtonSegment<ThemeStyle>(
                  value: ThemeStyle.dark,
                  label: Text(AppLocalizations.of(context)!.settingsDark)),
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

// -------------------------------------------/
//  widget used in the SettingsScreen widget /
//-------------------------------------------/
enum Language { english, spanish }

class LanguageChoice extends StatefulWidget {
  const LanguageChoice({super.key, required this.l10nNotifier});
  final L10nNotifier l10nNotifier;

  @override
  State<LanguageChoice> createState() => _LanguageChoiceState();
}

class _LanguageChoiceState extends State<LanguageChoice> {
  late Language language;

  @override
  void initState() {
    super.initState();
    language = widget.l10nNotifier.appLocale == const Locale('en')
        ? Language.english
        : Language.spanish;
    BackButtonInterceptor.add(myInterceptor, zIndex: 2, name: 'SomeName');
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName('SomeName');
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    context.go('/');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SegmentedButton<Language>(
            segments: <ButtonSegment<Language>>[
              ButtonSegment<Language>(
                  value: Language.english,
                  label: Text(AppLocalizations.of(context)!.settingsEnglish)),
              ButtonSegment<Language>(
                  value: Language.spanish,
                  label: Text(AppLocalizations.of(context)!.settingsSpanish)),
            ],
            selected: <Language>{language},
            onSelectionChanged: (Set<Language> newSelection) {
              setState(() {
                language = newSelection.first;
                if (language == Language.english) {
                  widget.l10nNotifier.setLanguage(const Locale('en'));
                } else {
                  widget.l10nNotifier.setLanguage(const Locale('es'));
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
