import 'dart:developer' as developer;
import 'package:flutter/material.dart';

void showFlashError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(message),
    ),
  );
  developer.log(name: 'showFlashError', message);
}

// create a sucess message
void showFlashSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Text(message),
    ),
  );
  developer.log(name: 'showFlashSuccess', message);
}
