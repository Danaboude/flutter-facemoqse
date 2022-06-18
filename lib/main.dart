import 'dart:convert';
import 'dart:io' show Platform;

import 'package:facemosque/Screen/homescreen.dart';
import 'package:facemosque/Screen/splachScreen.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosque.dart';
import 'package:facemosque/widget/notificationHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:flutter/services.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';

changeStatusColor(Color color) async {
  var _useWhiteStatusBarForeground;
  var _useWhiteNavigationBarForeground;
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      _useWhiteStatusBarForeground = true;
      _useWhiteNavigationBarForeground = true;
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      _useWhiteStatusBarForeground = false;
      _useWhiteNavigationBarForeground = false;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> initAutoStart() async {
  isAutoStartAvailable;

  try {
    bool? test = await isAutoStartAvailable;
    print(test);
    if (!test!) await getAutoStartPermission();
  } on PlatformException catch (e) {
    print(e);
  }
}

void calladan() async {}

NotificationHelper _notificationHelper = NotificationHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  changeStatusColor(Color(0xFF1ea345));

  if (Platform.isAndroid) {
    initAutoStart();
  }

  _notificationHelper.initializeNotification();
  // _notificationHelper.cancelAll();

  alarmadan('fajer');
  alarmadan('dhuhr');
  alarmadan('asr');
  alarmadan('magrib');
  alarmadan('isha');

  runApp(const MyApp());
}

void alarmadan(String adan) async {
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
          //await _notificationHelper.cancel(0);
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
            //  _notificationHelper.cancel(1);

            var timehm = mosque.dhuhr.split(':');
            print('dhuhr');
            await _notificationHelper.scheduledNotification(
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
            //_notificationHelper.cancel(2);

            var timehm = mosque.asr.split(':');
            print('asr');
            await _notificationHelper.scheduledNotification(
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
            // await _notificationHelper.cancel(3);

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
            //await _notificationHelper.cancel(4);

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
