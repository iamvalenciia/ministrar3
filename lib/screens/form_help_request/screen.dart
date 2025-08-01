import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_routes.dart';
import '../../provider/activity_provider.dart';
import '../../provider/help_points.dart';
import '../../provider/loading_provider.dart';
import '../../provider/my_hr_provider.dart';
import '../../provider/theme_provider.dart';
import '../../theme.dart';

enum Category { food, medicine, others }

Category getCategoryFromString(String category) {
  switch (category) {
    case 'food':
      return Category.food;
    case 'medicine':
      return Category.medicine;
    case 'others':
      return Category.others;
    default:
      return Category.food; // Default category
  }
}

class HelpRequestFormScreen extends StatefulWidget {
  const HelpRequestFormScreen({super.key, this.initialHelpRequestId});

  final String? initialHelpRequestId;

  @override
  _HelpRequestFormScreenState createState() => _HelpRequestFormScreenState();
}

class _HelpRequestFormScreenState extends State<HelpRequestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _contentController;
  late final TextEditingController _phoneController;
  late final TextEditingController _twitterController;
  late final TextEditingController _instagramController;
  Category dropdownValue = Category.food;
  bool _locationSharingEnable = false;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor, zIndex: 2, name: 'creating');
    final myHelpRequest = context.read<MyHelpRequestNotifier>().myHelpRequest;
    _contentController = TextEditingController();
    _phoneController = TextEditingController();
    _twitterController = TextEditingController();
    _instagramController = TextEditingController();
    _isEditing = myHelpRequest != null;
    if (_isEditing && myHelpRequest != null) {
      _contentController.text = myHelpRequest.content ?? '';
      _phoneController.text = myHelpRequest.phone_number ?? '';
      _twitterController.text = myHelpRequest.x_username ?? '';
      _instagramController.text = myHelpRequest.instagram_username ?? '';
      dropdownValue = getCategoryFromString(myHelpRequest.category ?? 'other');
      _locationSharingEnable = myHelpRequest.location_sharing_enabled ?? false;
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName('creating');
    _contentController.dispose();
    _phoneController.dispose();
    _twitterController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushNamed(
      AppRoutes.home,
    );
    return true;
  }

  Future<void> showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('information'),
              Text(AppLocalizations.of(context)!.ownerUserHelpsYou,
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
          actions: <Widget>[
            TextButton(
                onPressed: null,
                child: Text(AppLocalizations.of(context)!.ownerResponseYes)),
            TextButton(
                onPressed: null,
                child: Text(AppLocalizations.of(context)!.ownerResponseNo)),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
    final activitiesNotifier = context.read<ActivityNotifier>();
    final int helpPoint =
        Provider.of<HelpPoints>(context).userHelpPoints?.points ?? 0;
    final ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    final isDarkModeOn = themeProvider.themeDataStyle == ThemeDataStyle.dark;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Card.filled(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!
                      .createThisAppWilluseYourCurrentLocation)),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.createSelectCategory,
                style: TextStyle(color: Theme.of(context).colorScheme.outline)),
            CategoryChoice(
              myHelpRequestNotifier: myHelpRequestNotifier,
              selectedCategory: dropdownValue,
              onCategoryChanged: (Category newCategory) {
                setState(() {
                  dropdownValue = newCategory;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _contentController,
              maxLength: 240,
              maxLines: 6,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: AppLocalizations.of(context)!.createTypeYouhelp,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!
                      .usernameThisfieldcantBeEmpty;
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Card.filled(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.createFillOut,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.helperPhoneNumber,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _twitterController,
              decoration: const InputDecoration(
                labelText: 'X Twitter',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _instagramController,
              decoration: const InputDecoration(
                labelText: 'Instagram',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // IconButton(
            //   icon: Icon(Icons.info),
            //   onPressed: () {
            //     showConfirmationDialog();
            //   },
            // ),
            Card.outlined(
              child: CheckboxListTile(
                title: ListTile(
                  title: Text(
                    AppLocalizations.of(context)!
                        .createAllowUsersToViewLocation,
                    style: const TextStyle(fontSize: 14),
                  ),
                  leading: const FaIcon(
                    FontAwesomeIcons.locationDot,
                  ),
                ),
                value: _locationSharingEnable,
                onChanged: (bool? value) {
                  setState(() {
                    _locationSharingEnable = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity
                    .trailing, //  places the control on the start or leading side
              ),
            ),
            const SizedBox(height: 20),
            // Card.filled(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text('You have: $helpPoint ',
            //             style: TextStyle(
            //                 color: Theme.of(context).colorScheme.primary,
            //                 // fontWeight: FontWeight.bold,
            //                 fontSize: 16)),
            //         Icon(
            //           Icons.volunteer_activism,
            //           color: Theme.of(context).colorScheme.primary,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Row(
              children: [
                Card.filled(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          '3  ',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              // fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Icon(
                          Icons.volunteer_activism,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<LoadingNotifier>(
                    builder: (_, loadingNotifier, __) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Ajusta este valor para controlar la curvatura de los bordes
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          loadingNotifier.setLoading(true);
                          final appLocalizations = AppLocalizations.of(context);
                          final messenger = ScaffoldMessenger.of(context);
                          final themeContext = Theme.of(context);
                          final navigateTo = Navigator.of(context);

                          try {
                            if (_contentController.text.isNotEmpty &&
                                (_phoneController.text.isNotEmpty ||
                                    _twitterController.text.isNotEmpty ||
                                    _instagramController.text.isNotEmpty)) {
                              if (_isEditing) {
                                // Update existing help request
                                final success = await myHelpRequestNotifier
                                    .updateMyHelpRequest(
                                  dropdownValue.name,
                                  _contentController.text,
                                  _phoneController.text,
                                  _twitterController.text,
                                  _instagramController.text,
                                  _locationSharingEnable,
                                );

                                if (success) {
                                  navigateTo.pushNamed(AppRoutes.myHelpRequest);
                                  messenger.showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          themeContext.colorScheme.primary,
                                      content: Text(appLocalizations!
                                          .createHelpRequestUpdated),
                                    ),
                                  );
                                } else if (!success) {
                                  navigateTo.pushNamed(AppRoutes.myHelpRequest);
                                }
                              } else {
                                // Create new help request
                                final success = await myHelpRequestNotifier
                                    .createMyHelpRequest(
                                  dropdownValue.name,
                                  _contentController.text,
                                  _phoneController.text,
                                  _twitterController.text,
                                  _instagramController.text,
                                  _locationSharingEnable,
                                );

                                if (success) {
                                  activitiesNotifier.createLocalPostActivity();
                                  navigateTo.pushNamed(AppRoutes.myHelpRequest);
                                  messenger.showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          themeContext.colorScheme.primary,
                                      content: Text(appLocalizations!
                                          .createHelpRequestCreated),
                                    ),
                                  );
                                }
                              }
                            } else {
                              messenger.showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      themeContext.colorScheme.error,
                                  content: Text(
                                      appLocalizations!.createPleaseFillout),
                                ),
                              );
                            }
                          } catch (e) {
                            messenger.showSnackBar(
                              SnackBar(
                                backgroundColor: themeContext.colorScheme.error,
                                content: Text(e.toString()),
                              ),
                            );
                          } finally {
                            loadingNotifier.setLoading(false);
                          }
                        } else {}
                      },
                      child: loadingNotifier.isLoading
                          ? const LinearProgressIndicator()
                          : Text(
                              _isEditing
                                  ? AppLocalizations.of(context)!
                                      .createUpdateHelpRequest
                                  : AppLocalizations.of(context)!
                                      .createHelpRequest,
                              style: TextStyle(
                                color: isDarkModeOn
                                    ? Theme.of(context).colorScheme.scrim
                                    : Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------/
//  widget used in the HelpRequestFormScreen widget /
//--------------------------------------------------/
class CategoryChoice extends StatefulWidget {
  const CategoryChoice({
    super.key,
    required this.myHelpRequestNotifier,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final MyHelpRequestNotifier myHelpRequestNotifier;
  final Category selectedCategory;
  final ValueChanged<Category> onCategoryChanged;

  @override
  _CategoryChoiceState createState() => _CategoryChoiceState();
}

class _CategoryChoiceState extends State<CategoryChoice> {
  late Category selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SegmentedButton<Category>(
            segments: <ButtonSegment<Category>>[
              ButtonSegment<Category>(
                  value: Category.food,
                  label: Text(AppLocalizations.of(context)!.createAliments)),
              ButtonSegment<Category>(
                  value: Category.medicine,
                  label: Text(AppLocalizations.of(context)!.createMedicine)),
              ButtonSegment<Category>(
                  value: Category.others,
                  label: Text(AppLocalizations.of(context)!.createOthers)),
            ],
            selected: <Category>{selectedCategory},
            onSelectionChanged: (Set<Category> newSelection) {
              setState(() {
                selectedCategory = newSelection.first;
                widget.onCategoryChanged(selectedCategory);
              });
            },
          ),
        ),
      ],
    );
  }
}
