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

String personalizedTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inHours >= 1 && difference.inHours < 24) {
    return '${difference.inHours}h';
  } else if (difference.inDays >= 1 && difference.inDays <= 6) {
    return '${difference.inDays}d';
  } else if (difference.inDays > 6) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year % 100}';
  } else {
    return 'Just now';
  }
}
