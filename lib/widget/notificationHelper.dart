import 'package:facemosque/providers/messagefromtaipc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> _configureLocalTimeZone() async {
    //initialize timezone
    tz.initializeTimeZones();
    //get local time zone
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
   //get location from timezone
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  /// Initialize notification
  initializeNotification() async {
    _configureLocalTimeZone();
    //ios setting but i not set
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
   //set icon notification the same as icon app
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
   //Initialize setting notification
    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Set right date and time for notifications
  //if time adan has pass the day  it well add day 
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
    return scheduleDate;
  }
//Notification for firebase 
  showNot(MessageFromTaipc message) async {
    await flutterLocalNotificationsPlugin.show(
     message.hashCode,
     message.title,
      message.message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id asdf',
          'abdalkremm',
          channelDescription: 'socool',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(sound: 'assets/mp3/notification.mp3'),
      ),
      payload: 'It could be anything you pass',
    );
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
          'your channel id 2',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound(sound),
        ),
        iOS: DarwinNotificationDetails(sound:'$sound.mp3'),
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

  cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  cancel(id) async => await flutterLocalNotificationsPlugin.cancel(id);
}
