import 'package:carousel_slider/carousel_slider.dart';
import 'package:facemosque/Screen/musqScreen.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosque.dart';
import 'package:facemosque/widget/countdowntimer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facemosque/Screen/eventnotifications.dart';
import 'package:facemosque/Screen/settingsscreen.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/widget/bottomnav.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MySlider {
  String time;
  String timeend;
  String adan;
  MySlider({
    required this.time,
    required this.timeend,
    required this.adan,
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
    //ask for locationPermission in homeScreen
    Provider.of<FatchData>(context, listen: false).locationPermission();
    //call mosque form provider (FatchData) if not select mosque it well show Noting in All Text
    Mosque mosque = Provider.of<FatchData>(context).mosque;
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
      ),
      MySlider(
        time: mosque.sharouq,
        timeend: ' ',
        adan: language['sharouq'],
      ),
      MySlider(
          time: mosque.dhuhr, timeend: mosque.dhuhri, adan: language['dhuhr']),
      MySlider(time: mosque.asr, timeend: mosque.asri, adan: language['asr']),
      MySlider(
          time: mosque.magrib,
          timeend: mosque.magribi,
          adan: language['magrib']),
      MySlider(time: mosque.isha, timeend: mosque.isha, adan: language['isha']),
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        // cearte bottomNavigationBar 
        bottomNavigationBar: const BottomNav(),
        // safeArea insets its child by sufficient padding to avoid intrusions by the operating system. 
        body: SafeArea(
          child: Container(
            // background color(white) of app
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: [
                //if user select Home icon in app index(0) it's well show HomeScrean
                Provider.of<Buttonclickp>(context).indexnavigationbottmbar == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: AutoSizeText(
                              //show word in en or ar as lebal
                              language['titlenamemasjed'],
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Text(
                            //show name of mosque user select if not select it well show nothing
                            Provider.of<FatchData>(context).mosqueFollow.name,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          CarouselSlider(
                              options: CarouselOptions(
                                //take 28% of height size phone for this widget (cart)
                                height: sizedphone.height * 0.28,
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
                                        height: sizedphone.height * 0.28,
                                      //take 90% of height size phone for this widget
                                        width: sizedphone.width * 0.9,
                                        //leave space 8 form left and right  of widget
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        padding: const EdgeInsets.all(8),
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
                                              //name of adan 
                                              item.adan,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1,
                                            ),
                                            const SizedBox(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                //show word adan or اذان as lebal
                                                Text(language['adan'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1),
                                                const SizedBox(),
                                                Text(language['prayer'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                //time adan
                                                Text(item.time,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1),
                                                SizedBox(
                                                  width:
                                                      sizedphone.width * 0.09,
                                                ),
                                                //time المقام
                                                Text(item.timeend,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1),
                                              ],
                                            ),
                                          ],
                                        )),
                                  )
                                  .toList()),
                          Container(
                            height: sizedphone.height * 0.5,
                            width: sizedphone.width * 0.9,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffD1B000), width: 3),
                              borderRadius: BorderRadius.circular(40),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // I cearte method for next parer and today aya with seam shape and color and pass text
                                titlel(language['nextparer']),
                                CountdownTimer(),
                                titlel(language['todayaya']),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.topCenter,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 9),
                                      //AutoSizeText it well Change the font size to fit inside widget
                                      // That you gave it a certain size(height,wdith) of the phone screan size
                                  child: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    // if language ar it well show haditha else it well show hadithe
                                    Provider.of<Buttonclickp>(context)
                                            .languageselected
                                        ? mosque.haditha.toString()
                                        : mosque.hadithe.toString(),
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
      child: Text(titlel, style: Theme.of(context).textTheme.headline1),
    );
  }
}
