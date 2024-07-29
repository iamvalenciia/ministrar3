import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import '../models/help_points_model/help_points_model.dart';
import '../services/supabase.dart';

class HelpPoints extends ChangeNotifier {
  HelpPointsModel? _userHelpPoints;

  HelpPointsModel? get userHelpPoints => _userHelpPoints;

  Future<void> fetchHelpPoints() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      developer.log(
        'FetchHelpPoints...',
        name: 'fetchHelpPoints',
      );
      final data = await supabase
          .from('help_points')
          .select('points')
          .eq('user_id', userId.toString())
          .single();

      _userHelpPoints = HelpPointsModel.fromJson(data);

      developer.log(
        userHelpPoints.toString(),
        name: 'fetchHelpPoints after ...',
      );
    } catch (error) {
      developer.log(
        error.toString(),
        name: 'ERROR fetchHelpPoints',
      );
    }
  }
}
