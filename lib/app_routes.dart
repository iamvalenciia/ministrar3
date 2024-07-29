import 'package:flutter/material.dart';
import 'screens/form_help_request/screen.dart';
import 'screens/form_username/screen.dart';
import 'screens/help_request_for_helpers/screen.dart';
import 'screens/help_request_for_owners/screen.dart';
import 'screens/home/screen.dart';
import 'screens/profile/screen.dart';
import 'screens/settings/screent.dart';

class AppRoutes {
  // Define route names as static constants
  static const String home = '/';
  static const String helpRequest = '/help_request';
  static const String profile = '/profile';
  static const String editUserName = '/edit_user_name';
  static const String myHelpRequest = '/my_help_request';
  static const String createHelpRequest = '/create_help_request';
  static const String preference = '/preference';

  // Route configuration
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreenBody());
      case helpRequest:
        final args = settings.arguments! as Map<String, dynamic>;
        final id = args['id'] as String;
        return MaterialPageRoute(
          builder: (_) => HelpRequestForHelpers(helpRequestUserId: id),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case editUserName:
        return MaterialPageRoute(builder: (_) => const UsernameFormScreen());
      case myHelpRequest:
        return MaterialPageRoute(builder: (_) => HelpRequestForOwners());
      case createHelpRequest:
        return MaterialPageRoute(builder: (_) => const HelpRequestFormScreen());
      case preference:
        return MaterialPageRoute(builder: (_) => const PreferenceScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreenBody());
    }
  }
}
