import 'package:flutter/material.dart';
import 'locator.dart';

import 'routes.dart';

void main() {
  // locator to inject providers
  setupLocator();

  // // notifications
  // AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //       channelKey: 'sleep_reminder',
  //       channelName: 'Sleep Reminder Notifications',
  //       defaultColor: colorScheme.primary,
  //       importance: NotificationImportance.High,
  //       channelShowBadge: true,
  //       channelDescription: '',
  //     )
  //   ],
  // );

  // app
  runApp(const App());
}
