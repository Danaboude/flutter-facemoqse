import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
        Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  /// Initialize notification
  initializeNotification() async {
    _configureLocalTimeZone();
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Set right date and time for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    print(scheduleDate);
    return scheduleDate;
  }



  /// Scheduled Notification
  scheduledNotification({
    required String title,
    required bool body,
    required int hour,
    required int minutes,
    required int id,
    required String sound,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      body == false ? 'It\'s time for adan' : 'حان موعد اذان ',
      title,
      _convertTime(hour, minutes),
      
      NotificationDetails(

        android: AndroidNotificationDetails(
          'your channel id $sound',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound(sound),
        ),
        iOS: IOSNotificationDetails(sound: '$sound.mp3'),
      ),
      
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'It could be anything you pass',
    );
  }

  /// Request IOS permissions
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  cancelAll() async => await flutterLocalNotificationsPlugin.cancelAll();
  cancel(id) async => await flutterLocalNotificationsPlugin.cancel(id);
}
