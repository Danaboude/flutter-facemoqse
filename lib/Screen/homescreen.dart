import 'dart:async';

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
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Text(
                          Provider.of<FatchData>(context).namemosqs,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
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
                                        border: Border.all(
                                            color: const Color(0xffD1B000),
                                            width: 3),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.green,
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(40),
                                        gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF2F5233),
                                              Color(0xFF1ea345),
                                            ],
                                            begin: FractionalOffset(0.0, 0.0),
                                            end: FractionalOffset(0.1, 0.7),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            item.day,
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(item.time,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(),
                                              Text(item.timeend,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          )
                                        ],
                                      )),
                                )
                                .toList()),
                        
                        Container(
                          height: sizedphone.height * 0.39,
                          width: sizedphone.width * 0.8,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xffD1B000), width: 3),
                           boxShadow: const [
                                          BoxShadow(
                                            color: Colors.green,
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                          ),
                                        ],
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF2F5233),
                                  Color(0xFF1ea345),
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
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
                                    ? mosque.haditha
                                    : mosque.hadithe,
                              ))
                            ],
                          ),
                        )
                      ],
                    )
                  : Provider.of<Buttonclickp>(context).indexnavigationbar == 1
                      ? const MusqScreen()
                      : Provider.of<Buttonclickp>(context).indexnavigationbar == 2
                          ? const EventNotifications()
                          : const SettingsScreen(),
            ],
          ),
        ),
      )
    );
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}
