import 'dart:async';
import 'dart:convert';

import 'package:facemosque/Screen/homescreen.dart';
import 'package:facemosque/Screen/splachScreen.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosque.dart';
import 'package:facemosque/widget/notificationHelper.dart';
//import 'package:facemosque/widget/notificationHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

NotificationHelper _notificationHelper = NotificationHelper();
callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await _notificationHelper.initializeNotification();
    alarmadan('fajer');
    alarmadan('dhuhr');
    alarmadan('asr');
    alarmadan('magrib');
    alarmadan('isha');
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Workmanager().initialize(callbackDispatcher);
 // await Workmanager().registerPeriodicTask("test_workertask", "test_workertask",frequency: Duration(hours: 12),initialDelay: Duration(days: 1), existingWorkPolicy: ExistingWorkPolicy.replace);
    await _notificationHelper.initializeNotification();
    alarmadan('fajer');
    alarmadan('dhuhr');
    alarmadan('asr');
    alarmadan('magrib');
    alarmadan('isha');


  runApp(const MyApp());
}

void alarmadan(String adan) async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.local);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool lang = false;
  if (prefs.containsKey('language')) {
    lang = prefs.getBool('language')!;
  }
  if (prefs.containsKey(adan)) {
    bool adanstate = prefs.getBool(adan)!;
    print(adanstate);
    if (adanstate) {
      if (prefs.containsKey('mosque')) {
        Mosque mosque =
            Mosque.fromJson(json.decode(prefs.getString('mosque')!));
        if (adan == 'fajer') {
          if (mosque.fajer != '') {
            var timehm = mosque.fajer.split(':');
            _notificationHelper.scheduledNotification(
              body: lang,
              title: lang ? 'الفجر' : adan,
              hour: int.parse(timehm[0]),
              minutes: int.parse(timehm[1]),
              id: 0,
              sound: 'adan',
            );
            print('fajer');
          }
        } else if (adan == 'dhuhr') {
          if (mosque.dhuhr != '') {
            var timehm = mosque.dhuhr.split(':');
            print('dhuhr');
            _notificationHelper.scheduledNotification(
              body: lang,
              title: lang ? 'الظهر' : adan,
              hour: int.parse(timehm[0]),
              minutes: int.parse(timehm[1]),
              id: 1,
              sound: 'adan',
            );
            // notifsetting( 0, lang,lang ? 'الفجر' : adan,_nextInstanceOfTenAM(  int.parse(timehm[0]), int.parse(timehm[1])));
          }
        } else if (adan == 'asr') {
          if (mosque.asr != '') {
            var timehm = mosque.asr.split(':');
            print('asr');
            _notificationHelper.scheduledNotification(
              body: lang,
              title: lang ? 'العصر' : adan,
              hour: int.parse(timehm[0]),
              minutes: int.parse(timehm[1]),
              id: 2,
              sound: 'adan',
            );
            // notifsetting( 0, lang,lang ? 'الفجر' : adan,_nextInstanceOfTenAM(  int.parse(timehm[0]), int.parse(timehm[1])));
          }
        } else if (adan == 'magrib') {
          if (mosque.magrib != '') {
            var timehm = mosque.magrib.split(':');
            print('magrib');
            _notificationHelper.scheduledNotification(
              body: lang,
              title: lang ? 'المغرب' : adan,
              hour: int.parse(timehm[0]),
              minutes: int.parse(timehm[1]),
              id: 3,
              sound: 'adan',
            );
            // notifsetting( 0, lang,lang ? 'الفجر' : adan,_nextInstanceOfTenAM(  int.parse(timehm[0]), int.parse(timehm[1])));
          }
        } else if (adan == 'isha') {
          if (mosque.isha != '') {
            var timehm = mosque.isha.split(':');
            print('isha');
            _notificationHelper.scheduledNotification(
              body: lang,
              title: lang ? 'العشاء' : adan,
              hour: int.parse(timehm[0]),
              minutes: int.parse(timehm[1]),
              id: 4,
              sound: 'adan',
            );
            // notifsetting( 0, lang,lang ? 'الفجر' : adan,_nextInstanceOfTenAM(  int.parse(timehm[0]), int.parse(timehm[1])));
          }
        }
      }
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Buttonclickp()),
        ChangeNotifierProvider.value(value: FatchData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Al-Jazeera',
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            //  headline1: TextStyle(color: Colors.white),
            // headline2: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.black),
            //  subtitle1: TextStyle(color: Colors.pinkAccent),
          ),
        ),
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
        },
        home: const SplachScreen(),
      ),
    );
  }
}
