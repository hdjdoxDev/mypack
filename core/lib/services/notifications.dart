import 'package:flutter/material.dart';

abstract class INotificationApi {
  static late INotificationApi _instance;
  static bool _instanceIsSet = false;

  static Future<INotificationApi> getInstance() async {
    if (_instanceIsSet == false) {
      _instanceIsSet = true;
      _instance = NotificationApi();
    }
    return _instance;
  }

  Future<void> init() async {}

  Future<void> showNotification(String title, String body) async {}

  Future<void> cancelNotification() async {}

  Future<void> cancelAllNotifications() async {}

  Future<void> scheduleNotification(
      String title, String body, DateTime time) async {}

  Future<void> scheduleDailyNotification(
      String title, String body, TimeOfDay time) async {}

  Future<void> scheduleWeeklyNotification(
      String title, String body, TimeOfDay time, List<int> days) async {}

  Future<void> scheduleMonthlyNotification(
      String title, String body, TimeOfDay time, List<int> days) async {}
}

class NotificationApi implements INotificationApi {
  NotificationApi();

  @override
  Future<void> init() async {}

  @override
  Future<void> showNotification(String title, String body) async {}

  @override
  Future<void> cancelNotification() async {}

  @override
  Future<void> cancelAllNotifications() async {}

  @override
  Future<void> scheduleNotification(
      String title, String body, DateTime time) async {}

  @override
  Future<void> scheduleDailyNotification(
      String title, String body, TimeOfDay time) async {}

  @override
  Future<void> scheduleWeeklyNotification(
      String title, String body, TimeOfDay time, List<int> days) async {}

  @override
  Future<void> scheduleMonthlyNotification(
      String title, String body, TimeOfDay time, List<int> days) async {}
}
