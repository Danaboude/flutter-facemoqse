import 'dart:convert';
import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:facemosque/Screen/adminControlScreen.dart';
import 'package:facemosque/Screen/authscreen.dart';
import 'package:facemosque/Screen/contactUs.dart';
import 'package:facemosque/Screen/musqScreen.dart';
import 'package:facemosque/providers/auth.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosque.dart';
import 'package:facemosque/providers/respray.dart';
import 'package:facemosque/widget/countdowntimer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:facemosque/Screen/eventnotifications.dart';
import 'package:facemosque/Screen/settingsscreen.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/widget/bottomnav.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/swipe.dart';
import "package:flutter/material.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

//import "package:persistent_bottom_nav_bar_example_project/custom-widget-tabs.widget.dart";
//import "package:persistent_bottom_nav_bar_example_project/screens.dart";
import '../main.dart';
import '../providers/messagefromtaipc.dart';
import '../widget/notificationHelper.dart';

class MySlider {
  String time;
  String timeend;
  String adan;
  bool Issharouq;
  MySlider(
      {required this.time,
      required this.timeend,
      required this.adan,
      required this.Issharouq});
}

class HomeScreen extends StatefulWidget {
  static const routeName = '/Home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationHelper _notificationHelper = NotificationHelper();
  late PersistentTabController _controller;
  late bool _hideNavBar;
  @override
  void initState() {
    read();
    super.initState();
    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void read() async {
    FirebaseMessaging.instance.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<MessageFromTaipc> list = [];
      if (preferences.containsKey('listmessage')) {
        final List<dynamic> jsonData =
            jsonDecode(preferences.getString('listmessage')!);
        list = jsonData.map<MessageFromTaipc>((jsonList) {
          return MessageFromTaipc.fromJson(jsonList);
        }).toList();
      }
      MessageFromTaipc messagetaipc = MessageFromTaipc.fromJson(message.data);
      print(messagetaipc.toString());
      list.add(messagetaipc);
      preferences.setString('listmessage', MessageFromTaipc.encode(list));
      await Firebase.initializeApp();
      _notificationHelper.showNot(messagetaipc);
    });
  }

  @override
  Widget build(BuildContext context) {
    //ask for locationPermission in homeScreen
    Provider.of<FatchData>(context, listen: false).locationPermission();
    //call mosque form provider (FatchData) if not select mosque it well show Noting in All Text
    Mosque mosque = Provider.of<FatchData>(context).mosque;

    String mosquefollow = Provider.of<FatchData>(context).mosqueFollow.name;
    String msoqueFollowEmail =
        Provider.of<FatchData>(context).mosqueFollow.Email;

    //call Map(languagepro) from provider (Buttonclickp) return en language as default
    //have all key of word we need
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    //MediaQuery well get size of phone like height and  height
    var sizedphone = MediaQuery.of(context).size;
    // List of Slider to show 5 cart of time adan
    //Every key language[''] well get word in en or ar
    List<MySlider> slider = [
      MySlider(
          time: mosque.fajer,
          timeend: mosque.fajeri,
          adan: language['fajer'],
          Issharouq: false),
      MySlider(
          time: mosque.sharouq,
          timeend: ' ',
          adan: language['sharouq'],
          Issharouq: true),
      MySlider(
          time: mosque.dhuhr,
          timeend: mosque.dhuhri,
          adan: language['dhuhr'],
          Issharouq: false),
      MySlider(
          time: mosque.asr,
          timeend: mosque.asri,
          adan: language['asr'],
          Issharouq: false),
      MySlider(
          time: mosque.magrib,
          timeend: mosque.magribi,
          adan: language['magrib'],
          Issharouq: false),
      MySlider(
          time: mosque.isha,
          timeend: mosque.ishai,
          adan: language['isha'],
          Issharouq: false),
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        // cearte bottomNavigationBar
        bottomNavigationBar: const BottomNav(),
        // safeArea insets its child by sufficient padding to avoid intrusions by the operating system.
        body: Swipe(
          onSwipeLeft: () async {
            if (Provider.of<Buttonclickp>(context, listen: false)
                    .indexnavigationbottmbar !=
                1) {
              if (Provider.of<Auth>(context, listen: false).user == null)
                Navigator.of(context).pushNamed(AuthScreen.routeName);
              else {
                Navigator.of(context).pushNamed(AdminControlScreen.routeName);
              }
            }
          },
          child: SafeArea(
            child: Container(
              // background color(white) of app
              color: const Color.fromARGB(255, 255, 255, 255),

              child: ListView(
                physics: Provider.of<Buttonclickp>(context)
                            .indexnavigationbottmbar ==
                        1
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  //if user select Home icon in app index(0) it's well show HomeScrean
                  Provider.of<Buttonclickp>(context).indexnavigationbottmbar ==
                          0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: sizedphone.width * 0.95,
                                height: 100,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/quranbackground.jpg"),
                                      fit: BoxFit.cover,
                                      opacity: 0.05),
                                  border: Border.all(
                                      color: const Color(0xffD1B000), width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context).primaryColor,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: AutoSizeText(
                                    //show word in en or ar as lebal
                                    language['titlenamemasjed'] +
                                        "\n" +
                                        mosquefollow,

                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Al-Jazeera",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    // Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                )),

                            //show name of mosque user select if not select it well show nothing

                            Stack(
                              children: [
                                CarouselSlider(
                                    options: CarouselOptions(
                                      //take 28% of height size phone for this widget (cart)
                                      height: sizedphone.height * 0.23,
                                      scrollDirection: Axis.horizontal,
                                      //to keep scroll forever
                                      enableInfiniteScroll: true,
                                      autoPlay: true,
                                      viewportFraction: 1,
                                      disableCenter: false,
                                    ),
                                    // get list of slider to map it well show count of item i have added to list
                                    // with each item I can Show name of adan and time
                                    items: slider
                                        .map(
                                          (item) => Container(
                                              //take 28% of height size phone for this widget
                                              height: sizedphone.height * 0.15,
                                              //take 90% of height size phone for this widget
                                              width: sizedphone.width * 0.95,
                                              //leave space 8 form left and right  of widget
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/backgroundprayers.png"),
                                                    fit: BoxFit.cover,
                                                    opacity: 0.1),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xffD1B000),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    //name of adan
                                                    item.Issharouq
                                                        ? item.adan +
                                                            "\n" +
                                                            item.time
                                                        : item.adan,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(),
                                                  if (!item.Issharouq)
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        //show word adan or اذان as lebal
                                                        Text(
                                                            item.Issharouq
                                                                ? ""
                                                                : language[
                                                                    'adan'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1),
                                                        const SizedBox(),
                                                        Text(
                                                            item.Issharouq
                                                                ? ""
                                                                : language[
                                                                    'prayer'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1),
                                                      ],
                                                    ),
                                                  if (!item.Issharouq)
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        //time adan
                                                        Text(item.time,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1),
                                                        SizedBox(
                                                          width:
                                                              sizedphone.width *
                                                                  0.095,
                                                        ),
                                                        //time المقام
                                                        Text(item.timeend,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1),
                                                      ],
                                                    ),
                                                ],
                                              )),
                                        )
                                        .toList()),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            language['Times are being update']),
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ));
                                      await updateMosuqe();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                language['Updated'],
                                              ),
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: sizedphone.height * 0.58,
                              width: sizedphone.width * 0.95,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/quranbackground.jpg"),
                                    fit: BoxFit.cover,
                                    opacity: 0.05),
                                border: Border.all(
                                    color: const Color(0xffD1B000), width: 2),
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // I cearte method for next parer and today aya with seam shape and color and pass text
                                  titlel(language['nextparer']),
                                  mosque.isha != ''
                                      ? DateFormat("hh:mm")
                                              .parse(mosque.isha.split(':')[0] +
                                                  ':' +
                                                  mosque.isha.split(':')[1])
                                              .isAfter(DateFormat("hh:mm").parse(
                                                  DateTime.now().hour.toString() +
                                                      ':' +
                                                      DateTime.now()
                                                          .minute
                                                          .toString()))
                                          ? const CountdownTimer()
                                          : Text(language['Today\'s prayers are over'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1)
                                      : Text(
                                          language[
                                              'Select the mosque to see the last prayer'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(fontSize: 15)),
                                  titlel(language['todayaya']),
                                  Expanded(
                                      child: Container(
                                    /*decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/quranbackground.jpg"),
                                          fit: BoxFit.cover,
                                          opacity: 0.05),
                                    ),*/
                                    alignment: Alignment.topCenter,

                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9),
                                    //AutoSizeText it well Change the font size to fit inside widget
                                    // That you gave it a certain size(height,wdith) of the phone screan size

                                    child: AutoSizeText(
                                      textAlign: TextAlign.center,
                                      // if language ar it well show haditha else it well show hadithe
                                      mosque.horA == 0
                                          ? Provider.of<Buttonclickp>(context)
                                                  .languageselected
                                              ? mosque.haditha.toString()
                                              : mosque.hadithe.toString()
                                          : Provider.of<Buttonclickp>(context)
                                                  .languageselected
                                              ? mosque.qurana.toString()
                                              : mosque.qurane.toString(),
                                      //give text style of headline 1 (I set in main.dart)
                                      //but it well change the font size to 20

                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                            fontSize: 20,
                                          ),
                                    ),
                                  ))
                                ],
                              ),
                            )
                          ],
                        )
                      // if user click favorite icon index(1) it well show MusqScreen
                      : Provider.of<Buttonclickp>(context)
                                  .indexnavigationbottmbar ==
                              1
                          ? const MusqScreen()
                          // if user click Notification icon index(2) it well show EventNotifications
                          : Provider.of<Buttonclickp>(context)
                                      .indexnavigationbottmbar ==
                                  2
                              ? const EventNotifications()
                              //else  click Setting icon index(3) it well show Settings
                              : const SettingsScreen(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: msoqueFollowEmail.isNotEmpty,
          child: FloatingActionButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(contactUs.routeName),

            // Add your onPressed code here!

            backgroundColor: Colors.white,
            child: const Icon(Icons.contact_support_sharp,
                color: Color(0xFF94C973)),
          ),
        ));
  }

  Container titlel(String titlel) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF94C973),
      ),
      alignment: Alignment.center,
      child: Text(titlel, style: Theme.of(context).textTheme.headline1),
    );
  }
}
