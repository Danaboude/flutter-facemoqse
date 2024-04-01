import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosques.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../widget/notificationHelper.dart';

//TODO: creating a menua with different Muazan and deleting the notification checkboxs as they are in the main interfeca @ibrahim
//Model of Language
class Language {
  String lang;
  Language({
    required this.lang,
  });
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

enum Language1 { englich, arabic }

class _SettingsScreenState extends State<SettingsScreen> {
  NotificationHelper _notificationHelper = NotificationHelper();
  @override
  Widget build(BuildContext context) {
    Language1? language1 = Provider.of<Buttonclickp>(context).languageselected
        ? Language1.arabic
        : Language1.englich;

    Mosques mosquefollow =
        Provider.of<FatchData>(context, listen: false).mosqueFollow;

    var sizedphone = MediaQuery.of(context).size;
    Map language = Provider.of<Buttonclickp>(context).languagepro;

//Make list of Language to select one of them
    List<Language> l = [
      //show word in en or ar as lebal
      Language(lang: language['englich']),
      Language(lang: language['arabic'])
    ];
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            //take 2% of height size phone
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
              //give text style of headline 1 (I set in main.dart)
              //but it well change the font size to 20
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(
            height: sizedphone.height * 0.07,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                      value: Provider.of<Buttonclickp>(context).sala[0],
                      onChanged: mosquefollow.isFavrote
                          ? (bool? i) async {
                              //make fajer alarm on or off ever time you push button fajer
                              Provider.of<Buttonclickp>(context, listen: false)
                                  .chackDayWeek(0);
                              //store value of fajer in SharedPreferences
                              Provider.of<Buttonclickp>(context, listen: false)
                                  .storesalaDay();
                              //if button fajer was off
                              if (!i!) {
                                //cancel adan fajer
                                _notificationHelper.cancel(0);
                              } else {
                                await _notificationHelper
                                    .initializeNotification();
                                //set adan fajer on
                                alarmadan('fajer');
                              }
                            }
                          : null,
                      activeColor: Theme.of(context).primaryColor),
                ),
                Text(
                  language['fajer'],
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 14),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                      value: Provider.of<Buttonclickp>(context).sala[1],
                      onChanged: mosquefollow.isFavrote
                          ? (bool? i) async {
                              Provider.of<Buttonclickp>(context, listen: false)
                                  .chackDayWeek(1);

                              Provider.of<Buttonclickp>(context, listen: false)
                                  .storesalaDay();
                              if (!i!) {
                                _notificationHelper.cancel(1);
                              } else {
                                await _notificationHelper
                                    .initializeNotification();

                                alarmadan('dhuhr');
                              }
                            }
                          : null,
                      activeColor: Theme.of(context).primaryColor),
                ),
                Text(
                  language['dhuhr'],
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 14),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                      value: Provider.of<Buttonclickp>(context).sala[2],
                      onChanged: mosquefollow.isFavrote
                          ? (bool? i) async {
                              Provider.of<Buttonclickp>(context, listen: false)
                                  .chackDayWeek(2);

                              Provider.of<Buttonclickp>(context, listen: false)
                                  .storesalaDay();
                              if (!i!) {
                                _notificationHelper.cancel(2);
                              } else {
                                await _notificationHelper
                                    .initializeNotification();
                                alarmadan('asr');
                              }
                            }
                          : null,
                      activeColor: Theme.of(context).primaryColor),
                ),
                Text(
                  language['asr'],
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 14),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                    value: Provider.of<Buttonclickp>(context).sala[3],
                    onChanged: mosquefollow.isFavrote
                        ? (bool? i) async {
                            Provider.of<Buttonclickp>(context, listen: false)
                                .chackDayWeek(3);

                            Provider.of<Buttonclickp>(context, listen: false)
                                .storesalaDay();
                            if (!i!) {
                              _notificationHelper.cancel(3);
                            } else {
                              await _notificationHelper
                                  .initializeNotification();
                              alarmadan('magrib');
                            }
                          }
                        : null,
                    activeColor: Theme.of(context).primaryColor),
              ),
              Text(
                language['magrib'],
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(fontSize: 14),
              ),
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                    value: Provider.of<Buttonclickp>(context).sala[4],
                    onChanged: mosquefollow.isFavrote
                        ? (bool? i) async {
                            Provider.of<Buttonclickp>(context, listen: false)
                                .chackDayWeek(4);

                            Provider.of<Buttonclickp>(context, listen: false)
                                .storesalaDay();
                            if (!i!) {
                              _notificationHelper.cancel(4);
                            } else {
                              await _notificationHelper
                                  .initializeNotification();
                              alarmadan('isha');
                            }
                          }
                        : null,
                    activeColor: Theme.of(context).primaryColor),
              ),
              Text(
                language['isha'],
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(fontSize: 14),
              )
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
            height: sizedphone.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform.scale(
                scale: 1.3,
                child: Radio<Language1?>(
                    groupValue: Language1.englich,
                    value: language1,
                    onChanged: (val) {
                      Provider.of<Buttonclickp>(context, listen: false)
                          .storelanguage(false);
                    },
                    activeColor: Theme.of(context).primaryColor),
              ),
              Text(
                l[0].lang,
                style: Theme.of(context).textTheme.headline2,
              ),
              Transform.scale(
                scale: 1.3,
                child: Radio<Language1?>(
                    groupValue: Language1.arabic,
                    value: language1,
                    onChanged: (val) {
                      Provider.of<Buttonclickp>(context, listen: false)
                          .storelanguage(true);
                    },
                    activeColor: Theme.of(context).primaryColor),
              ),
              Text(
                l[1].lang,
                style: Theme.of(context).textTheme.headline2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
