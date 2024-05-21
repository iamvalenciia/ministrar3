import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/l10n_provider.dart';
import '../../provider/onboarding_provider.dart';
import '../../provider/theme_provider.dart';
import '../../theme.dart';
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
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final L10nNotifier l10nNotifier =
        Provider.of<L10nNotifier>(context, listen: false);
    final ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    final OnboardingNavigation onboardingNavigation =
        Provider.of<OnboardingNavigation>(context, listen: false);

    return Scaffold(
      body: Column(children: [
        Expanded(
          child: PageView(
            onPageChanged: (index) {
              onboardingNavigation.setNavigationIndex(index);
              tabController?.index = index;
            },
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
                    padding: const EdgeInsets.symmetric(horizontal: 28),
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
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: LanguageChoice(l10nNotifier: l10nNotifier),
                  ),
                ],
              ),
              // PAGE #2 - Find Opportunities
              Column(
                children: [
                  Expanded(
                    child: Selector<L10nNotifier, bool>(
                      selector: (_, l10nNotifier) =>
                          // ignore: avoid_bool_literals_in_conditional_expressions
                          l10nNotifier.appLocale == const Locale('en')
                              ? true
                              : false,
                      builder: (_, isEnglish, __) {
                        final isDarkModeOn =
                            themeProvider.themeDataStyle == ThemeDataStyle.dark;
                        String imagePath;

                        if (isEnglish) {
                          imagePath = isDarkModeOn
                              ? 'assets/app_images/5help_dark_en.png'
                              : 'assets/app_images/5help_light_en.png';
                        } else {
                          imagePath = isDarkModeOn
                              ? 'assets/app_images/5help_dark_es.png'
                              : 'assets/app_images/5help_light_es.png';
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Card.outlined(
                            // elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.contain,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
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
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 90, left: 14, right: 14),
                    child: Text(AppLocalizations.of(context)!.onboardingTheHome,
                        style: const TextStyle(fontSize: 20)),
                  ),
                ],
              ),
              // PAGE #3 - Create Help Requests
              Column(
                children: [
                  Expanded(
                    child: Selector<L10nNotifier, bool>(
                      selector: (_, l10nNotifier) =>
                          // ignore: avoid_bool_literals_in_conditional_expressions
                          l10nNotifier.appLocale == const Locale('en')
                              ? true
                              : false,
                      builder: (_, isEnglish, __) {
                        final isDarkModeOn =
                            themeProvider.themeDataStyle == ThemeDataStyle.dark;
                        String imagePath;

                        if (isEnglish) {
                          imagePath = isDarkModeOn
                              ? 'assets/app_images/create_dark_en.png'
                              : 'assets/app_images/create_light_en.png';
                        } else {
                          imagePath = isDarkModeOn
                              ? 'assets/app_images/create_dark_es.png'
                              : 'assets/app_images/create_light_es.png';
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Card(
                            // elevation: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.contain,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 90, bottom: 20, left: 14),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.onboardingCreate,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 60, left: 14, right: 14),
                    child: Text(AppLocalizations.of(context)!.onboardingAfter,
                        style: const TextStyle(fontSize: 20)),
                  ),
                ],
              ),
              // PAGE #4 - HELP BOTTOM
              Column(
                children: [
                  Expanded(
                    child: Selector<L10nNotifier, bool>(
                      selector: (_, l10nNotifier) =>
                          // ignore: avoid_bool_literals_in_conditional_expressions
                          l10nNotifier.appLocale == const Locale('en')
                              ? true
                              : false,
                      builder: (_, isEnglish, __) {
                        final isDarkModeOn =
                            themeProvider.themeDataStyle == ThemeDataStyle.dark;
                        String imagePath;

                        if (isEnglish) {
                          imagePath = isDarkModeOn
                              ? 'assets/app_images/bottom_dark_en.png'
                              : 'assets/app_images/bottom_light_en.png';
                        } else {
                          imagePath = isDarkModeOn
                              ? 'assets/app_images/bottom_dark_es.png'
                              : 'assets/app_images/bottom_light_es.png';
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Card(
                            // elevation: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.contain,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 90, bottom: 20, left: 14),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.onboardingHelp,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 60, left: 14, right: 14),
                    child: Text(
                        AppLocalizations.of(context)!.onboardingHowToHelp,
                        style: const TextStyle(fontSize: 20)),
                  ),
                ],
              ),
              // PAGE #5 - GRADE HELP
              Column(
                children: [
                  Expanded(
                    child: Selector<L10nNotifier, bool>(
                      selector: (_, l10nNotifier) =>
                          // ignore: avoid_bool_literals_in_conditional_expressions
                          l10nNotifier.appLocale == const Locale('en')
                              ? true
                              : false,
                      builder: (_, isEnglish, __) {
                        final isDarkModeOn =
                            themeProvider.themeDataStyle == ThemeDataStyle.dark;
                        String imagePath;

                        if (isEnglish) {
                          imagePath = isDarkModeOn
                              ? 'assets/app_images/help_dark_en.png'
                              : 'assets/app_images/help_light_en.png';
                        } else {
                          imagePath = isDarkModeOn
                              ? 'assets/app_images/help_dark_es.png'
                              : 'assets/app_images/help_light_es.png';
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Card(
                            // elevation: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.contain,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 90, bottom: 20, left: 14),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.onboardingRate,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 60, left: 14, right: 14),
                    child: Text(AppLocalizations.of(context)!.onboardingYouCan,
                        style: const TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 14, right: 14),
          child: Row(
            children: [
              TabPageSelector(controller: tabController),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  final navigateTo = GoRouter.of(context);
                  if (tabController?.index == 4) {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('hasSeenOnboarding', true);
                    navigateTo.go('/');
                    tabController?.index = 0;
                    onboardingNavigation.setNavigationIndex(0);
                  } else {
                    onboardingNavigation
                        .setNavigationIndex(tabController!.index);
                    _controller.animateToPage(
                      tabController!.index + 1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Selector<OnboardingNavigation, bool>(
                  selector: (_, onboardingNavigation) =>
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      onboardingNavigation.navigationIndex == 4 ? true : false,
                  builder: (_, isNavigationIndex3, __) => Text(
                    isNavigationIndex3
                        ? AppLocalizations.of(context)!.onboardingFinish
                        : AppLocalizations.of(context)!.onboardingNext,
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
