import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosque.dart';
import 'package:facemosque/providers/respray.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';

class PrayerTimeSreen extends StatefulWidget {
  static const routeName = '/preyertime';

  @override
  State<PrayerTimeSreen> createState() => _PrayerTimeSreenState();
}

class _PrayerTimeSreenState extends State<PrayerTimeSreen> {
  String command = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GroupButtonController settingController = GroupButtonController();
  GroupButtonController payerController = GroupButtonController();

  @override
  Widget build(BuildContext context) {
    var sizedphone = MediaQuery.of(context).size;
    int _currentIntValue =
        Provider.of<Buttonclickp>(context, listen: false).counteraddparyer;
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    String settings = Provider.of<Buttonclickp>(context).settingEdit;
    String prayer = Provider.of<Buttonclickp>(context).parerEdit;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: sizedphone.height * 0.03,
              ),
              titlel(language['Chooses Prayer'], 1, sizedphone),
              SizedBox(
                height: sizedphone.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GroupButton(
                  controller: payerController,
                  options: GroupButtonOptions(
                      borderRadius: BorderRadius.circular(25)),
                  onSelected: (index, isSelected, t) {
                    Provider.of<Buttonclickp>(context, listen: false)
                        .setParerEdit(index.toString());
                    print('$index button is selected');
                  },
                  buttons: [
                    language['fajer'],
                    language['dhuhr'],
                    language['asr'],
                    language['magrib'],
                    language['isha'],
                  ],
                ),
              ),
              SizedBox(
                height: sizedphone.height * 0.01,
              ),
              titlel(language['Chooses'], 2, sizedphone),
              SizedBox(
                height: sizedphone.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GroupButton(
                  controller: settingController,
                  options: GroupButtonOptions(
                      borderRadius: BorderRadius.circular(25)),
                  onSelected: (index, isSelected, t) {
                    Provider.of<Buttonclickp>(context, listen: false)
                        .SetSettingEdit(index.toString());
                    print('$index button is selected');
                  },
                  buttons: [
                    language["Prayer Settings"],
                    language["Iqamah Settings"]
                  ],
                ),
              ),
              SizedBox(
                height: sizedphone.height * 0.01,
              ),
              titlel(language['Chooses Time'], 3, sizedphone),
              SizedBox(
                height: sizedphone.height * 0.01,
              ),
              NumberPicker(
                itemCount: 3,
                infiniteLoop: true,
                value: _currentIntValue,
                minValue: -60,
                maxValue: 60,
                step: 1,
                onChanged: (value) {
                  Provider.of<Buttonclickp>(context, listen: false)
                      .setcunteraddparyer(value);
                },
              ),
              SizedBox(
                height: sizedphone.height * 0.02,
              ),
              ElevatedButton(
                  child: Text(language['Send Times']),
                  onPressed: () {
                    select(
                        settings, prayer, _currentIntValue, language['fajer']);
                    select(
                        settings, prayer, _currentIntValue, language['dhuhr']);
                    select(settings, prayer, _currentIntValue, language['asr']);
                    select(
                        settings, prayer, _currentIntValue, language['magrib']);
                    select(
                        settings, prayer, _currentIntValue, language['isha']);
                    if (command == '') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          language['please select Setting and prayer'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          language['time of prayer has been updated'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                      Navigator.of(context).pop();
                    }
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(13)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )))),
            ],
          ),
        ),
      ),
    );
  }

  void select(String settings, String prayer, int minute, String prayer1) {
    Map language =
        Provider.of<Buttonclickp>(context, listen: false).languagepro;
    Mosque mosque = Provider.of<FatchData>(context, listen: false).mosque;

    if (settings == language["Prayer Settings"]) {
      if (prayer == prayer1) {
        String time = language['fajer'] == prayer1
            ? mosque.fajer
            : language['dhuhr'] == prayer1
                ? mosque.dhuhr
                : language['asr'] == prayer1
                    ? mosque.asr
                    : language['magrib'] == prayer1
                        ? mosque.magrib
                        : language['isha'] == prayer1
                            ? mosque.isha
                            : '';
        var s = DateFormat("hh:mm").parse(time);
        Duration duration = Duration(minutes: minute);
        command = "PrayerTime prayer ${prayer} ${_printDuration(duration)}";
        //command = "PrayerTime ${language['fajer'] == prayer1 ? _printDuration(duration) : mosque.fajer} ${language['dhuhr'] == prayer1 ? _printDuration(duration) : mosque.dhuhr} ${language['asr'] == prayer1 ? _printDuration(duration) : mosque.asr} ${language['magrib'] == prayer1 ? _printDuration(duration) : mosque.magrib} ${language['isha'] == prayer1 ? _printDuration(duration) : mosque.isha}  ${mosque.fajeri}  ${mosque.dhuhri}   ${mosque.asri}  ${mosque.magribi}  ${mosque.ishai}";
        print(mosque.fajer);
        print(command);
        Provider.of<Respray>(context, listen: false).sendudp(command);
      }
    } else {
      if (prayer == prayer1) {
        String time = language['fajer'] == prayer1
            ? mosque.fajeri
            : language['dhuhr'] == prayer1
                ? mosque.dhuhri
                : language['asr'] == prayer1
                    ? mosque.asri
                    : language['magrib'] == prayer1
                        ? mosque.magribi
                        : language['isha'] == prayer1
                            ? mosque.ishai
                            : '';
        var s = DateFormat("hh:mm").parse(time);
        // Duration duration = Duration(hours: s.hour, minutes: s.minute + minute);
        Duration duration = Duration(minutes: minute);
        command = "PrayerTime iqamah ${prayer} ${_printDuration(duration)}";
        //command ="PrayerTime  ${mosque.fajer} ${mosque.dhuhr} ${mosque.asr} ${mosque.magrib} ${mosque.isha}  ${language['fajer'] == prayer1 ? _printDuration(duration) : mosque.fajeri}  ${language['dhuhr'] == prayer1 ? _printDuration(duration) : mosque.dhuhri}   ${language['asr'] == prayer1 ? _printDuration(duration) : mosque.asri}  ${language['magrib'] == prayer1 ? _printDuration(duration) : mosque.magribi}  ${language['isha'] == prayer1 ? _printDuration(duration) : mosque.ishai}";

        print(mosque.fajeri);
        print(command);
        Provider.of<Respray>(context, listen: false).sendudp(command);
      }
    }
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    return Duration(hours: hours, minutes: minutes);
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "$twoDigitMinutes";
  }

  Container titlel(String titlel, int i, Size s) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).primaryColor,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(),
          Text(titlel, style: Theme.of(context).textTheme.headline1),
          Container(
              height: s.height * 0.06,
              width: s.width * 0.1,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.white)),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '$i',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ))
        ],
      ),
    );
  }
}
