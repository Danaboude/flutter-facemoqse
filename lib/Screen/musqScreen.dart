import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:facemosque/widget/loctionmosque.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosques.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../widget/notificationHelper.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:latlong2/latlong.dart' as latlong;

class MusqScreen extends StatefulWidget {
  const MusqScreen({Key? key}) : super(key: key);

  @override
  State<MusqScreen> createState() => _MusqScreenState();

  static getState() => _MusqScreenState;
}

class _MusqScreenState extends State<MusqScreen> with TickerProviderStateMixin {
  NotificationHelper _notificationHelper = NotificationHelper();

  late Mosques mosquesforevent;
  late Mosques mosquefollow;
  @override
  Widget build(BuildContext context) {
    // get mosquefollow to show data like name mosque it show after select mosque from all mosque
    mosquefollow = Provider.of<FatchData>(context, listen: false).mosqueFollow;
    // get mosqueFollowevent to show data like name mosque it show after select mosque from all mosque
    mosquesforevent = Provider.of<FatchData>(context).mosqueFollowevent;
    //call Map(languagepro) from provider(Buttonclickp) return en language as default
    //have all key of word we need
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    //MediaQuery well get size of phone like height and  height
    var sizedphone = MediaQuery.of(context).size;
    //listmosque show all mosque for user
    var listmosque = Provider.of<FatchData>(context).mosquelist;
    latlong.LatLng l = Provider.of<FatchData>(context).latlng1;

    return SafeArea(
      //make Screan enble to Scroll
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                //take 6% of height size phone for this widget
                height: sizedphone.height * 0.06,
                //take 100% of width size phone for this widget
                width: sizedphone.width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Text(
                        //show word in en or ar as lebal
                        language['mymosque'],
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(fontSize: 16),
                      ),
                      onTap: () {
                        // if user prass my Mosque index(0) it well show All Mosque to select one of them
                        Provider.of<Buttonclickp>(context, listen: false)
                            .setindextab(0);
                      },
                    ),
                    InkWell(
                      child: Text(
                        language['othermosque'],
                        //give text style of headline 2 (I set in main.dart)
                        //but it well change the font size to 16
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(fontSize: 16),
                      ),
                      onTap: () {
                        // if user prass my Mosque index(1) it well show All Mosque to select one of them
                        Provider.of<Buttonclickp>(context, listen: false)
                            .setindextab(1);
                      },
                    )
                  ],
                )),
            //if indextab==0 (My Mousqe) it well show Screan MyMosuqe
            Provider.of<Buttonclickp>(context).indextab == 0
                ? Provider.of<Buttonclickp>(context).replacetoloc
                    //bulid methed return column for all mousqe well get data form listmosque
                    //(we read mosques data in splachScreen  from api) in Tap My mosuqe
                    // pass to method sizedphone(height and width of phone) and context
                    //and bool var if true it's we store mosquefollow  and show loction
                    //if false it's well store mosqueFollowevent fore mosuqe event
                    ? masqveiw(sizedphone, context, listmosque, true)
                    : Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffD1B000), width: 2),
                              borderRadius: BorderRadius.circular(40),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: ListTile(
                              leading: Image.asset('assets/images/mosque.png'),
                              //AutoSizeText it well Change the font size to fit inside widget
                              // That you gave it a certain size(height,wdith) of the phone screan size
                              title: AutoSizeText(
                                maxLines: 1,
                                //show name mosque we select
                                mosquefollow.name,
                                //give text style of headline 1 (I set in main.dart)
                                //but it well change the font size to 16
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(fontSize: 16),
                              ),
                              subtitle: AutoSizeText(
                                maxLines: 1,
                                //show country and street mosuqe we select
                                '${mosquefollow.country} , ${mosquefollow.street}',
                                //give text style of headline 1 (I set in main.dart)
                                //but it well change the font size to 14
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    // store mosquefollow.isFavrote=false in SharedPreferences
                                    // to set all alarm off
                                    Provider.of<FatchData>(context,
                                            listen: false)
                                        .setmosqueFollowFavrote(false);
                                    // store bool replacetoloc in SharedPreferences
                                    // when user select mosuqe and close app
                                    //it save what well show to user (All mousqe)
                                    Provider.of<Buttonclickp>(context,
                                            listen: false)
                                        .storereplacetoloc(true);
                                    // clean data mosuqe from SharedPreferences
                                    Provider.of<FatchData>(context,
                                            listen: false)
                                        .cleandata();
                                    //reload all mosque from api
                                    Provider.of<FatchData>(context,
                                            listen: false)
                                        .fatchandsetallmosque();
                                    //cancel all alarm
                                    _notificationHelper.cancelAll();
                                    Provider.of<Buttonclickp>(context,
                                            listen: false)
                                        //make all button adan Notification false
                                        .statesala([
                                      false,
                                      false,
                                      false,
                                      false,
                                      false,
                                      false,
                                      false
                                    ]);
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: mosquefollow.isFavrote
                                        ? const Color(0xFFd4af37)
                                        : Colors.grey,
                                  )),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    )
  )
),
                            onPressed: () {
                              MapLauncher.showMarker(
                                mapType: MapType.google,
                                coords: Coords(l.latitude, l.longitude),
                                title: 'Hi',
                                zoom: 20,
                              );
                            },
                            child:  Text(language['Take me to Google Map']),
                          ),
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                //  borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: const Color(0xffD1B000), width: 2),
                              ),
                              height: sizedphone.height * 0.62,
                              width: sizedphone.width * 0.9,
                              //class show Map and Laction mosuqe
                              child: LoctionMosque()),
                        ],
                      )
                //if indextab==1 (Other Mosuqe) it well show Screan MyMosuqe
                : Provider.of<Buttonclickp>(context).replacetoevent
                    //bulid methed return column for all mousqe well get data form listmosque
                    //(we read mosques data in splachScreen  from api) in Tap My mosuqe
                    // pass to method sizedphone(height and width of phone) and context
                    //and bool var if true it's we store mosquefollow  and show loction
                    //if false it's well store mosqueFollowevent fore mosuqe event
                    ? masqveiw(sizedphone, context, listmosque, false)
                    : Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              color: const Color(0xffD1B000), width: 3),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: ListTile(
                          leading: Image.asset('assets/images/mosque.png'),
                          title: AutoSizeText(
                            maxLines: 1,
                            mosquesforevent.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(fontSize: 16),
                          ),
                          subtitle: AutoSizeText(
                            maxLines: 1,
                            '${mosquesforevent.country} , ${mosquesforevent.street}',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  mosquesforevent.isFavrote =
                                      !mosquesforevent.isFavrote;
                                });
                                Provider.of<Buttonclickp>(context,
                                        listen: false)
                                    .storereplacetoevent(true);
                                Provider.of<FatchData>(context, listen: false)
                                    .fatchandsetallmosque();
                                unsubscribeTopic(mosquesforevent.name);
                              },
                              icon: Icon(Icons.star,
                                  color: const Color(0xFFd4af37))),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

//method i called 2 times to show all mosque for my mosque and other mosque
  Column masqveiw(Size sizedphone, BuildContext con, List<Mosques> listmosque,
      bool mymusque) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: sizedphone.width * 0.9,
          height: sizedphone.height * 0.08,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(color: const Color(0xffD1B000), width: 3),
          ),
          child: TextField(
            onChanged: (value) {
              //search bar to shearch for mosque
              Provider.of<FatchData>(con, listen: false).Searchval(value);
            },
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              filled: false,

              fillColor: Colors.white,
              // iconColor: Colors.black,
              focusColor: Colors.white,
              hoverColor: Colors.white,

              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              icon: const Icon(Icons.search),
              labelText:
                  Provider.of<Buttonclickp>(context).languagepro['searchbar'],
            ),
          ),
        ),
        SizedBox(
          height: sizedphone.height * 0.02,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(30)),
          height: sizedphone.height * 0.63,
          width: sizedphone.width * 0.96,
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            //show all mosque
            children: listmosque
                .map((item) => Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffD1B000), width: 3),
                        borderRadius: BorderRadius.circular(40),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () async {
                              //if user click my mosque and select mosque this code well run
                              if (mymusque) {
                                //clean all data form mosquefollow to set new
                                mosquefollow.clean();
                                // delate all mousqe to show the one we follow
                                Provider.of<Buttonclickp>(con, listen: false)
                                    .storereplacetoloc(false);
                                // fatch data for the mosque we follow form listmosque
                                //where id  the same as the mosque we select
                                mosquefollow = listmosque.firstWhere(
                                    (element) =>
                                        element.mosqueid == item.mosqueid);
                                //fatch mosque data form api using mosque id
                                await Provider.of<FatchData>(con, listen: false)
                                    .fatchandsetmosque(mosquefollow.mosqueid);
                                // store mosquefollow.isFavrote=true in SharedPreferences
                                // to set all alarm on
                                await Provider.of<FatchData>(context,
                                        listen: false)
                                    .setmosqueFollowFavrote(true);
                                //make all button adan Notification true
                                Provider.of<Buttonclickp>(context,
                                        listen: false)
                                    .statesala([
                                  true,
                                  true,
                                  true,
                                  true,
                                  true,
                                  true,
                                  true
                                ]);
                                //stoe list sala in SharedPreferences
                                Provider.of<Buttonclickp>(context,
                                        listen: false)
                                    .storesalaDay();
                                //set alarm for all adan
                                calladan();
                                //remove mosquefollow from listmosque
                                listmosque.removeWhere((element) =>
                                    element.mosqueid == mosquefollow.mosqueid);
                                //read All data form SharedPreferences
                                await Provider.of<FatchData>(con, listen: false)
                                    .readdata();
                                //back to home page to load map loction if you want see loction go back to Favrote Screen
                                //if i not back to home page camera map well not move
                                Provider.of<Buttonclickp>(context,
                                        listen: false)
                                    .indexNavigationBar(0);
                                //if user click other mosque and select mosque this code well run
                              } else {
                                // delate all mousqe to show the one we followevent
                                Provider.of<Buttonclickp>(con, listen: false)
                                    .storereplacetoevent(false);

                                setState(() {
                                  item.isFavrote = !item.isFavrote;
                                });
                                // fatch data for the mosque we followevent form listmosque
                                //where id  the same as the mosque we select
                                mosquesforevent = listmosque.firstWhere(
                                    (element) =>
                                        element.mosqueid == item.mosqueid);
                                subscribeTopic(mosquesforevent.name);
                                //remove mosquefollowevent from listmosque
                                listmosque.removeWhere((element) =>
                                    element.mosqueid ==
                                    mosquesforevent.mosqueid);
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setString('mosquesforevent',
                                    json.encode(mosquesforevent.toMap()));

                                //read All data form SharedPreferences
                                await Provider.of<FatchData>(con, listen: false)
                                    .readdata();
                              }
                            },
                            icon: Icon(
                              Icons.star,
                              color: Colors.grey,
                            )),
                        leading: Image.asset('assets/images/mosque.png'),
                        title: AutoSizeText(
                          item.name,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontSize: 16),
                        ),
                        subtitle: AutoSizeText(
                          maxLines: 1,
                          '${item.country} , ${item.street}',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  void subscribeTopic(String name) async {
    _notificationHelper.initializeNotification();
    await FirebaseMessaging.instance
        .subscribeToTopic(name)
        .then((value) => print(name));
  }

  void unsubscribeTopic(String name) async {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(name)
        .then((value) => print(name));
  }
}
