import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosque.dart';
import 'package:facemosque/providers/mosques.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../widget/notificationHelper.dart';

class Mylangwch {
  String lang;

  Mylangwch({
    required this.lang,
  });
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  NotificationHelper _notificationHelper = NotificationHelper();

  bool selectedv = false;

  @override
  Widget build(BuildContext context) {
      mosques  mosquefollow = Provider.of<FatchData>(context, listen: false).mosqueFollow;

    var sizedphone = MediaQuery.of(context).size;
    Map language = Provider.of<Buttonclickp>(context).languagepro;

    List<Mylangwch> l = [
      Mylangwch(lang: language['englich']),
      Mylangwch(lang: language['arabic'])
    ];
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: sizedphone.height * 0.02,
          ),
          Container(
            alignment: Alignment.center,
            width: sizedphone.width * 0.9,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(40)),
            margin: const EdgeInsets.all(10),
            child: Text(
              language['azannotification'],
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(
            height: sizedphone.height * 0.07,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilterChip(
                
                
                checkmarkColor: Colors.white,
                label: Text(
                  language['fajer'],
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 14),
                ),
                onSelected: mosquefollow.isFavrote?(bool i) async {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(0);
                  Provider.of<Buttonclickp>(context, listen: false)
                      .storeDaysWeek();
                  if (!i) {
                    _notificationHelper.cancel(0);
                  } else {
                    await _notificationHelper.initializeNotification();

                    alarmadan('fajer');
                  }
                }:null,
                selected: Provider.of<Buttonclickp>(context).sala[0],
                backgroundColor: Theme.of(context).primaryColor,
                selectedColor: const Color(0xffD1B000),
              ),
              FilterChip(
                checkmarkColor: Colors.white,
                label: Text(
                  language['dhuhr'],
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 14),
                ),
                onSelected: mosquefollow.isFavrote? (bool i) async {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(1);

                  Provider.of<Buttonclickp>(context, listen: false)
                      .storeDaysWeek();
                  if (!i) {
                    _notificationHelper.cancel(1);
                  } else {
                    await _notificationHelper.initializeNotification();

                    alarmadan('dhuhr');
                  }
                }:null,
                selected: Provider.of<Buttonclickp>(context).sala[1],
                backgroundColor: Theme.of(context).primaryColor,
                selectedColor: const Color(0xffD1B000),
              ),
              FilterChip(
                checkmarkColor: Colors.white,
                label: Text(
                  language['asr'],
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 14),
                ),
                onSelected:  mosquefollow.isFavrote?(bool i) async {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(2);

                  Provider.of<Buttonclickp>(context, listen: false)
                      .storeDaysWeek();
                  if (!i) {
                    _notificationHelper.cancel(2);
                  } else {
                    await _notificationHelper.initializeNotification();
                    alarmadan('asr');
                  }
                }:null,
                selected: Provider.of<Buttonclickp>(context).sala[2],
                backgroundColor: Theme.of(context).primaryColor,
                selectedColor: const Color(0xffD1B000),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilterChip(
                checkmarkColor: Colors.white,
                label: Text(
                  language['magrib'],
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 14),
                ),
                onSelected:  mosquefollow.isFavrote?(bool i) async {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(3);

                  Provider.of<Buttonclickp>(context, listen: false)
                      .storeDaysWeek();
                  if (!i) {
                    _notificationHelper.cancel(3);
                  } else {
                    await _notificationHelper.initializeNotification();
                    alarmadan('magrib');
                  }
                }:null,
                selected: Provider.of<Buttonclickp>(context).sala[3],
                backgroundColor: Theme.of(context).primaryColor,
                selectedColor: const Color(0xffD1B000),
              ),
              FilterChip(
                checkmarkColor: Colors.white,
                label: Text(
                  language['isha'],
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 14),
                ),
                onSelected: mosquefollow.isFavrote? (bool i) async {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(4);

                  Provider.of<Buttonclickp>(context, listen: false)
                      .storeDaysWeek();
                  if (!i) {
                    _notificationHelper.cancel(4);
                  } else {
                    await _notificationHelper.initializeNotification();
                    alarmadan('isha');
                  }
                }:null,
                selected: Provider.of<Buttonclickp>(context).sala[4],
                backgroundColor: Theme.of(context).primaryColor,
                selectedColor: const Color(0xffD1B000),
              ),
            ],
          ),
          SizedBox(
            height: sizedphone.height * 0.06,
          ),
          Container(
            alignment: Alignment.center,
            width: sizedphone.width * 0.9,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(40)),
            margin: const EdgeInsets.all(10),
            child: Text(
              language['language'],
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(
            height: sizedphone.height * 0.14,
            width: sizedphone.width * 0.3,
            child: PopupMenuButton<Mylangwch>(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  language['selectlanguage'],
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              onSelected: (Mylangwch select) {
                if (select.lang == 'عربي' || select.lang == 'Arabic') {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .selectlanguage(true);
                } else if (select.lang == 'انكليزي' ||
                    select.lang == 'englich') {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .selectlanguage(false);
                }
                {}
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              itemBuilder: (context) {
                return l
                    .map((item) => PopupMenuItem<Mylangwch>(
                          value: item,
                          child: Text(
                            item.lang,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ))
                    .toList();
              },
            ),
          )
        ],
      ),
    );
  }
}
