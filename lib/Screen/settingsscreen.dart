import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosques.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../widget/notificationHelper.dart';
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

class _SettingsScreenState extends State<SettingsScreen> {
  NotificationHelper _notificationHelper = NotificationHelper();
  @override
  Widget build(BuildContext context) {
      Mosques  mosquefollow = Provider.of<FatchData>(context, listen: false).mosqueFollow;

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
          
                Container(
        
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () =>
                  Navigator.of(context).pop(),
            ),
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilterChip(
                checkmarkColor: Colors.black,
                label: Text(
                  language['fajer'],
                  style: Theme.of(context)
                      .textTheme
                      .headline2 
                      ?.copyWith(fontSize: 14),
                ),
                //user click fajer button
                //if user not select mosque form My Mosque it well disable button
                onSelected: mosquefollow.isFavrote?(bool i) async {
                  //make fajer alarm on or off ever time you push button fajer
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(0);
                  //store value of fajer in SharedPreferences
                  Provider.of<Buttonclickp>(context, listen: false)
                      .storesalaDay();
                      //if button fajer was off
                  if (!i) {
                    //cancel adan fajer
                    _notificationHelper.cancel(0);
                  } else {
                    await _notificationHelper.initializeNotification();
                    //set adan fajer on
                    alarmadan('fajer');
                  }
                }:null,
                selected: Provider.of<Buttonclickp>(context).sala[0],
                backgroundColor: Theme.of(context).primaryColor,
                selectedColor: const Color(0xffD1B000),
              ),
              FilterChip(
                checkmarkColor: Colors.black,
                label: Text(
                  language['dhuhr'],
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 14),
                ),
                onSelected: mosquefollow.isFavrote? (bool i) async {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(1);

                  Provider.of<Buttonclickp>(context, listen: false)
                      .storesalaDay();
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
                checkmarkColor: Colors.black,
                label: Text(
                  language['asr'],
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 14),
                ),
                onSelected:  mosquefollow.isFavrote?(bool i) async {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(2);

                  Provider.of<Buttonclickp>(context, listen: false)
                      .storesalaDay();
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
                checkmarkColor: Colors.black,
                label: Text(
                  language['magrib'],
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 14),
                ),
                onSelected:  mosquefollow.isFavrote?(bool i) async {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(3);

                  Provider.of<Buttonclickp>(context, listen: false)
                      .storesalaDay();
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
                checkmarkColor: Colors.black,
                label: Text(
                  language['isha'],
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 14),
                ),
                onSelected: mosquefollow.isFavrote? (bool i) async {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .chackDayWeek(4);

                  Provider.of<Buttonclickp>(context, listen: false)
                      .storesalaDay();
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
            child: PopupMenuButton<Language>(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  language['selectlanguage'],
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              onSelected: (Language select) {
                //if language ar 
                if (select.lang == 'عربي' || select.lang == 'Arabic') {
                  //it well change to en
                  Provider.of<Buttonclickp>(context, listen: false)
                      .storelanguage(true);
                      //if language en
                } else if (select.lang == 'انكليزي' ||
                    select.lang == 'englich') {
                      //it well change to ar
                  Provider.of<Buttonclickp>(context, listen: false)
                      .storelanguage(false);
                }
               
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              itemBuilder: (context) {
                // l have 2 object en and ar well show in list
                return l
                    .map((item) => PopupMenuItem<Language>(
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
