import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/l10n_provider.dart';
import '../settings/screent.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _controller = PageController();
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final L10nNotifier l10nNotifier =
        Provider.of<L10nNotifier>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(children: [
          Expanded(
            child: PageView(
              onPageChanged: (index) => tabController?.index = index,
              controller: _controller,
              children: [
                // PAGE #1 - Welcome
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.onboardingWelcome,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary)),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                          AppLocalizations.of(context)!.onboardingTheFirst,
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.outline)),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.onboardingPleaseSelect,
                          style: TextStyle(
                              fontSize: 20,
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: LanguageChoice(l10nNotifier: l10nNotifier),
                    ),
                  ],
                ),
                // PAGE #2 - Find Opportunities
                Column(
                  children: [
                    Expanded(
                      child: Card.outlined(
                        child: Selector<L10nNotifier, bool>(
                          selector: (_, l10nNotifier) =>
                              // ignore: avoid_bool_literals_in_conditional_expressions
                              l10nNotifier.appLocale == const Locale('en')
                                  ? true
                                  : false,
                          builder: (_, isEnglish, __) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                opacity: 0.6,
                                image: isEnglish
                                    ? const AssetImage(
                                        'assets/app_images/find_opportunities_en.png')
                                    : const AssetImage(
                                        'assets/app_images/find_opportunities_es.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 90, bottom: 20, left: 14),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.onboardingFindHelp,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 100, left: 14, right: 14),
                      child: Text(
                          AppLocalizations.of(context)!.onboardingTheHome,
                          style: const TextStyle(fontSize: 22)),
                    ),
                  ],
                ),
                // PAGE #3 - Create Help Requests
                Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 8.0),
                        child: Card.outlined(
                          child: Selector<L10nNotifier, bool>(
                            selector: (_, l10nNotifier) =>
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                l10nNotifier.appLocale == const Locale('en')
                                    ? true
                                    : false,
                            builder: (_, isEnglish, __) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  opacity: 0.5,
                                  image: isEnglish
                                      ? const AssetImage(
                                          'assets/app_images/create_en.png')
                                      : const AssetImage(
                                          'assets/app_images/create_es.png'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 60, bottom: 20, left: 14),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.onboardingCreate,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 50, left: 14, right: 14),
                      child: Text(AppLocalizations.of(context)!.onboardingAfter,
                          style: const TextStyle(fontSize: 22)),
                    ),
                  ],
                ),
                Container(
                  color: Colors.indigo,
                  child: Column(
                    children: [
                      const Text('Page 3'),
                      ElevatedButton(
                        onPressed: () {
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setBool('onboarding', true);
                            GoRouter.of(context).go('/home');
                          });
                        },
                        child: const Text('Finish'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              TabPageSelector(controller: tabController),
            ],
          ),
        ]),
      ),
    );
  }
}
