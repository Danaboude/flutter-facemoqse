import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:facemosque/providers/mosque.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownTimer extends StatefulWidget {
  static const routeName = '/Home';

  const CountdownTimer({Key? key}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 0);
  @override
  void initState() {
    settimerformadan();
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());

    super.initState();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }



  void settimerformadan() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    DateTime now = DateFormat("hh:mm").parse(DateTime.now().hour.toString() +
        ':' +
        DateTime.now().minute.toString());

    if (preferences.containsKey('mosque')) {
      var timehm = ['0', '0'];
      Mosque mosque =
          Mosque.fromJson(json.decode(preferences.getString('mosque')!));
      if (DateFormat("hh:mm")
          .parse(mosque.fajer.split(':')[0] + ':' + mosque.fajer.split(':')[1])
          .isAfter(now)) {
        timehm = mosque.fajer.split(':');
      } else if (DateFormat("hh:mm")
          .parse(
              mosque.sharouq.split(':')[0] + ':' + mosque.sharouq.split(':')[1])
          .isAfter(now)) {
        timehm = mosque.sharouq.split(':');
      } else if (DateFormat("hh:mm")
          .parse(mosque.dhuhr.split(':')[0] + ':' + mosque.dhuhr.split(':')[1])
          .isAfter(now)) {
        timehm = mosque.dhuhr.split(':');
      } else if (DateFormat("hh:mm")
          .parse(mosque.asr.split(':')[0] + ':' + mosque.asr.split(':')[1])
          .isAfter(now)) {
        timehm = mosque.asr.split(':');
      } else if (DateFormat("hh:mm").parse(
          mosque.magrib.split(':')[0] + ':' + mosque.magrib.split(':')[1]).isAfter(now)) {
        timehm = mosque.magrib.split(':');
      } else if (DateFormat("hh:mm").parse(
          mosque.isha.split(':')[0] + ':' + mosque.isha.split(':')[1]).isAfter(now)) {
        timehm = mosque.isha.split(':');
      } else{
        timehm = ['0', '0'];
         countdownTimer?.cancel();
      }

      DateTime tempDate =
          DateFormat("hh:mm").parse(timehm[0] + ":" + timehm[1]);

      myDuration = Duration(
        seconds: tempDate.difference(now).inSeconds,
      );
      if(myDuration.inHours.remainder(24)<0){
        myDuration=Duration.zero;
      }

    }
  }

  // Step 6
  void setCountDown() async {
    final reduceSecondsBy = 1;

    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        settimerformadan();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return

        // Step 8
        Text(
      '$hours:$minutes:$seconds',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
