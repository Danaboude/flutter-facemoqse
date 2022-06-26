import 'package:carousel_slider/carousel_slider.dart';
import 'package:facemosque/Screen/musqScreen.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosque.dart';
import 'package:facemosque/widget/countdowntimer.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';

import 'package:facemosque/Screen/eventnotifications.dart';
import 'package:facemosque/Screen/settingsscreen.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/widget/bottomnav.dart';

class MySlider {
  String time;
  String timeend;
  String day;
  MySlider({
    required this.time,
    required this.timeend,
    required this.day,
  });
}

class HomeScreen extends StatefulWidget {
  static const routeName = '/Home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Mosque mosque = Provider.of<FatchData>(context).mosque;
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    print( mosque.haditha);

    List<MySlider> a = [
      MySlider(
        time: mosque.fajer,
        timeend: mosque.fajeri,
        day: language['fajer'],
      ),
      MySlider(
        time: mosque.sharouq,
        timeend: ' ',
        day: language['sharouq'],
      ),
      MySlider(
          time: mosque.dhuhr, timeend: mosque.dhuhri, day: language['dhuhr']),
      MySlider(time: mosque.asr, timeend: mosque.asri, day: language['asr']),
      MySlider(
          time: mosque.magrib,
          timeend: mosque.magribi,
          day: language['magrib']),
      MySlider(time: mosque.isha, timeend: mosque.isha, day: language['isha']),
    ];
    var sizedphone = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: const BottomNav(),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Provider.of<Buttonclickp>(context).indexnavigationbar == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              language['titlenamemasjed'],
                              style:Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Text(
                            Provider.of<FatchData>(context).namemosqs,
                            style:Theme.of(context).textTheme.headline2,
                          ),
                          CarouselSlider(
                              options: CarouselOptions(
                                scrollDirection: Axis.horizontal,
                                enableInfiniteScroll: true,
                                autoPlay: true,
                                viewportFraction: 1,
                                disableCenter: false,
                              ),
                              items: a
                                  .map(
                                    (item) => Container(
                                        margin: const EdgeInsets.all(40),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          border: Border.all(
                                              color: const Color(0xffD1B000),
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              item.day,
                                              style: Theme.of(context).textTheme.headline1,
                                            ),
                                            const SizedBox(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(language['adan'],
                                                    style:  Theme.of(context).textTheme.headline1),
                                                const SizedBox(),
                                                Text(language['prayer'],
                                                    style : Theme.of(context).textTheme.headline1),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(item.time,
                                                    style:  Theme.of(context).textTheme.headline1),
                                                 SizedBox(width: sizedphone.width*0.09,),
                                                Text(item.timeend,
                                                    style:Theme.of(context).textTheme.headline1),
                                              ],
                                            ),
                                          ],
                                        )),
                                  )
                                  .toList()),
                          Container(
                            height: sizedphone.height * 0.5,
                            width: sizedphone.width * 0.8,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffD1B000), width: 3),
                         
                              borderRadius: BorderRadius.circular(40),
                           color: Theme.of(context).primaryColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                titlel(language['nextparer']),
                                CountdownTimer(),
                                titlel(language['todayaya']),
                                Expanded(
                                    child: Text(
                                  Provider.of<Buttonclickp>(context)
                                          .languageselected
                                      ? mosque.qurana.toString()
                                      : mosque.qurane.toString(),style:  Theme.of(context).textTheme.headline1,
                                ))
                              ],
                            ),
                          )
                        ],
                      )
                    : Provider.of<Buttonclickp>(context).indexnavigationbar == 1
                        ? const MusqScreen()
                        : Provider.of<Buttonclickp>(context)
                                    .indexnavigationbar ==
                                2
                            ? const EventNotifications()
                            : const SettingsScreen(),
              ],
            ),
          ),
        ));
  }

  Container titlel(String titlel) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFF94C973),
      ),
      alignment: Alignment.center,
      child: Text(titlel,
          style:  Theme.of(context).textTheme.headline1),
    );
  }
}
