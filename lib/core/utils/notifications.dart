import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:igrejoteca_app/core/utils/reminder.dart';
import 'package:igrejoteca_app/core/utils/timestamp.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationHelper {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  final AndroidNotificationDetails _androidDetails = const AndroidNotificationDetails(
    'channelId',
    'channelName',
    channelDescription: '',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high
  );

  LocalNotificationHelper._internal();

  static final LocalNotificationHelper _localNotification = LocalNotificationHelper._internal();

  factory LocalNotificationHelper() {
    return _localNotification;
  }

  void selectNotification(String? payload) {

  }

  Future<void> init() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('ic_launcher');
    

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    tz.initializeTimeZones();

    await _plugin.initialize(settings);
  }

  Future<void> scheduleReminderNotifications(ReminderModel reminder) async {
    TimeOfDay timeUTC = timeOfDayUTC(reminder.time);

    tz.TZDateTime now = tz.TZDateTime.from(DateTime.now(), tz.UTC);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.UTC,
      now.year,
      now.month,
      now.day - 1,
      timeUTC.hour,
      timeUTC.minute
    );

    await _plugin.zonedSchedule(
      reminder.scheduleId,
      'MyMonchique Water Intake',
      "It's time to drink water",
      scheduledDate,
      NotificationDetails(android: _androidDetails),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
    );
  }

  Future<void> cancelNotifications(int id) async {
    await _plugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  Future<void> showNotification(String title, String body) async {
    await _plugin.show(999999, title, body, NotificationDetails(android: _androidDetails));
  }
}