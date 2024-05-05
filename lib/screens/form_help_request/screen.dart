import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/activity_provider.dart';
import '../../provider/loading_provider.dart';
import '../../provider/my_hr_provider.dart';

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
    _contentController.dispose();
    _phoneController.dispose();
    _twitterController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myHelpRequestNotifier = context.read<MyHelpRequestNotifier>();
    final activitiesNotifier = context.read<ActivityNotifier>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Card.filled(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'This app will use your current location at the time of this request to help nearby users see your help request and the distance to you',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            const SizedBox(height: 20),
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
              decoration: const InputDecoration(
                // labelText: 'Type your help request here ...',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field can't be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Card.filled(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Fill out at least one of the following contact fields',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field can't be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _twitterController,
              decoration: const InputDecoration(
                labelText: 'Twitter',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field can't be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _instagramController,
              decoration: const InputDecoration(
                labelText: 'Instagram',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field can't be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Card.filled(
              child: CheckboxListTile(
                title: Text(
                  'Enable others to view the location of this help request on a map',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.bold,
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
            Consumer<LoadingNotifier>(
              builder: (_, loadingNotifier, __) => ElevatedButton(
                onPressed: () async {
                  loadingNotifier.setLoading(true);

                  final messenger = ScaffoldMessenger.of(context);
                  final themeContext = Theme.of(context);
                  final navigateTo = GoRouter.of(context);

                  try {
                    if (_contentController.text.isNotEmpty &&
                        (_phoneController.text.isNotEmpty ||
                            _twitterController.text.isNotEmpty ||
                            _instagramController.text.isNotEmpty)) {
                      if (_isEditing) {
                        // Update existing help request
                        final success =
                            await myHelpRequestNotifier.updateMyHelpRequest(
                          dropdownValue.name,
                          _contentController.text,
                          _phoneController.text,
                          _twitterController.text,
                          _instagramController.text,
                          _locationSharingEnable,
                        );

                        if (success) {
                          activitiesNotifier.createLocalPostActivity();

                          navigateTo.go('/');
                          messenger.showSnackBar(
                            SnackBar(
                              backgroundColor: themeContext.colorScheme.primary,
                              content: const Text('Help request updated'),
                            ),
                          );
                        } else if (!success) {
                          navigateTo.go('/');
                        }
                      } else {
                        // Create new help request
                        final success =
                            await myHelpRequestNotifier.createMyHelpRequest(
                          dropdownValue.name,
                          _contentController.text,
                          _phoneController.text,
                          _twitterController.text,
                          _instagramController.text,
                          _locationSharingEnable,
                        );

                        if (success) {
                          activitiesNotifier.createLocalPostActivity();
                          navigateTo.go('/');
                          messenger.showSnackBar(
                            SnackBar(
                              backgroundColor: themeContext.colorScheme.primary,
                              content: const Text('Help request created'),
                            ),
                          );
                        }
                      }
                    } else {
                      messenger.showSnackBar(
                        SnackBar(
                          backgroundColor: themeContext.colorScheme.error,
                          content: const Text(
                              'Please fill out at least one contact field'),
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
                },
                child: loadingNotifier.isLoading
                    ? const LinearProgressIndicator()
                    : Text(_isEditing
                        ? 'Update Help Request'
                        : 'Create Help Request'),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

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
            segments: const <ButtonSegment<Category>>[
              ButtonSegment<Category>(
                  value: Category.food, label: Text('Food')),
              ButtonSegment<Category>(
                  value: Category.medicine, label: Text('Medicine')),
              ButtonSegment<Category>(
                  value: Category.others, label: Text('Others')),
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
