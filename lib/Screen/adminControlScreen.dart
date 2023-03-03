import 'dart:async';
import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:facemosque/Screen/LanguageScreen.dart';
import 'package:facemosque/Screen/authscreen.dart';
import 'package:facemosque/Screen/azanScreen.dart';
import 'package:facemosque/Screen/connectScreen.dart';
import 'package:facemosque/Screen/createnotificationsScreen.dart';
import 'package:facemosque/Screen/hijriScreen.dart';
import 'package:facemosque/Screen/information.dart';
import 'package:facemosque/Screen/messageScreen.dart';
import 'package:facemosque/Screen/prayerTimeScreen.dart';
import 'package:facemosque/Screen/resetScreen.dart';
import 'package:facemosque/Screen/screenScreen.dart';
import 'package:facemosque/Screen/themeScreen.dart';
import 'package:facemosque/Screen/volumeScreen.dart';
import 'package:facemosque/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:facemosque/Screen/homescreen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';
import '../providers/respray.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AdminControlScreen extends StatefulWidget {
  static const routeName = '/admincontrol';

  const AdminControlScreen({Key? key}) : super(key: key);

  @override
  State<AdminControlScreen> createState() => _AdminControlScreenState();
}

class GridItem {
  String url;
  String icon;
  String lebel;
  GridItem({
    required this.url,
    required this.icon,
    required this.lebel,
  });
}

class _AdminControlScreenState extends State<AdminControlScreen> {


  var _aspectTolerance = 0.00;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
    //  print('Couldn\'t check connectivity status $e');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    String lan = '';
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    List<GridItem> list = [
      GridItem(
          url: CreatenotificationsScreen.routeName,
          icon: 'assets/images/bell.png',
          lebel: language['Event Noititcations']),
      GridItem(
          url: Information.routeName,
          icon: 'assets/images/information.png',
          lebel: language['information']),
      GridItem(
          url: LanguageScreen.routeName,
          icon: 'assets/images/lang.png',
          lebel: language['language']),
      GridItem(
          url: ThemeScreen.routeName,
          icon: 'assets/images/theme.png',
          lebel: language['Theme']),
      GridItem(
          url: AzanScreen.routeName,
          icon: 'assets/images/azan.png',
          lebel: language['azan']),
      GridItem(
          url: HigiriScreen.routeName,
          icon: 'assets/images/calendar.png',
          lebel: language['Hijri']),
      GridItem(
          url: 'reboot',
          icon: 'assets/images/reboot.png',
          lebel: language['Reboot']),
      GridItem(
          url: ResetScreen.routeName,
          icon: 'assets/images/reset.png',
          lebel: language['Reset']),
      GridItem(
          url: ScreenScreen.routeName,
          icon: 'assets/images/screen.png',
          lebel: language['Screen']),
      GridItem(
          url: 'qr',
          icon: 'assets/images/qrscan.png',
          lebel: language['Scan QR Code']),
      GridItem(
          url: VolumeScreen.routeName,
          icon: 'assets/images/volume.png',
          lebel: language['volume']),
      GridItem(
          url: MessageScscreen.routeName,
          icon: 'assets/images/message.png',
          lebel: language['Message']),
      GridItem(
          url: PrayerTimeSreen.routeName,
          icon: 'assets/images/mosque.png',
          lebel: language['Prayer Time'])
    ];
    var sizedphone = MediaQuery.of(context).size;
    User user = Provider.of<Auth>(context).user!;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: sizedphone.height * 0.1,
            title: Row(
              children: [
                SizedBox(
                  width: sizedphone.width * 0.2,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${language['Admin']}",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                },
                icon: Icon(Icons.arrow_back_ios))),
        body: ListView(
          children: [
            Container(
              height: sizedphone.height * 0.78,
              width: sizedphone.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/quranbackground.jpg"),
                      fit: BoxFit.fill,
                      scale: 0.05,
                      opacity: 0.02)),
              padding: EdgeInsets.all(8),
              child: AnimationLimiter(
                child: GridView.builder(
                    physics: ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 8 / 6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int i) =>
                        AnimationConfiguration.staggeredGrid(
                          position: i,
                          duration: Duration(milliseconds: 500),
                          columnCount: 2,
                          child: ScaleAnimation(
                            duration: Duration(milliseconds: 900),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: FadeInAnimation(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: GestureDetector(
                                    onTap: () async {
                                      //
                                      if (list[i].url != 'reboot') {
                                        if (list[i].url == 'qr') {
                                        String  scanResult = await FlutterBarcodeScanner.scanBarcode(
                                          '#ff6666', 'Cancel', true, ScanMode.QR);
                                          if (scanResult != '') {
                                            Map a;
                                            if (json.decode(
                                                    scanResult)
                                                is Map) {
                                              a = json.decode(
                                                  scanResult);
                                            } else {
                                              a = {"Mobile Number": '1'};
                                            }
                                            await Provider.of<Auth>(context,
                                                    listen: false)
                                                .chackqr(a['Mobile Number']);

                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                title: Center(
                                                  child: Text(
                                                      ' ${a['First Name'] ?? ''} ${a['Last Name'] ?? language['not registered']}'),
                                                ),
                                                content: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    alignment: Alignment.center,
                                                    height:
                                                        sizedphone.height * 0.2,
                                                    width:
                                                        sizedphone.width * 0.7,
                                                    child: Icon(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      Provider.of<Auth>(context)
                                                              .chackuserinvide
                                                          ? Icons.check_circle
                                                          : Icons.close,
                                                      size: 100,
                                                    )),
                                                actions: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextButton.icon(
                                                      icon: Icon(Icons
                                                          .arrow_forward_ios_sharp),
                                                      onPressed: () async {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      label: Text(
                                                          language['Back']),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else if (list[i].url ==
                                            LanguageScreen.routeName) {
                                          await Provider.of<Buttonclickp>(
                                                  context,
                                                  listen: false)
                                              .storelanguageformosque();
                                          lan = await clickbuttongrid(
                                              context,
                                              lan,
                                              language,
                                              Provider.of<Buttonclickp>(context,
                                                      listen: false)
                                                  .languageformosqueselected,
                                              'Arabic',
                                              'arabic',
                                              'English',
                                              'englich',
                                              'Change Language');
                                        } else if (list[i].url ==
                                            ThemeScreen.routeName) {
                                          Provider.of<Buttonclickp>(context,
                                                  listen: false)
                                              .storetheme();
                                          lan = await clickbuttongrid(
                                              context,
                                              lan,
                                              language,
                                              Provider.of<Buttonclickp>(context,
                                                      listen: false)
                                                  .themeselected,
                                              'White',
                                              'white',
                                              'Black',
                                              'black',
                                              'Change Theme');
                                        } else if (list[i].url ==
                                            ResetScreen.routeName) {
                                          await Provider.of<Buttonclickp>(
                                                  context,
                                                  listen: false)
                                              .storereset();
                                          lan = await clickbuttongrid(
                                              context,
                                              lan,
                                              language,
                                              Provider.of<Buttonclickp>(context,
                                                      listen: false)
                                                  .resetselected,
                                              'reset',
                                              'Reset',
                                              'default',
                                              'Default',
                                              'Reset Mode');
                                        } else if (list[i].url ==
                                            ScreenScreen.routeName) {
                                          Provider.of<Buttonclickp>(context,
                                                  listen: false)
                                              .storeScreen();
                                          lan = await clickbuttongrid(
                                              context,
                                              lan,
                                              language,
                                              Provider.of<Buttonclickp>(context,
                                                      listen: false)
                                                  .screenselected,
                                              'sleep_def',
                                              'Always On',
                                              'sleep_no',
                                              'Default',
                                              'Change Screen Mode');
                                        } else {
                                          Navigator.of(context)
                                              .pushNamed(list[i].url);
                                        }
                                      } else {
                                        Provider.of<Respray>(context,
                                                listen: false)
                                            .sendudp('reboot');
                                        Timer(Duration(seconds: 2), () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              language[
                                                  'The restart command has been sent'],
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            duration:
                                                const Duration(seconds: 1),
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ));
                                        });
                                      }
                                    },
                                    child: GridTile(
                                      child: Container(
                                        //  margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.only(
                                            bottom: 60,
                                            left: 40,
                                            right: 40,
                                            top: 20),
                                        color: Colors.grey.withOpacity(0.2),
                                        height: sizedphone.height * 0.1,
                                        width: sizedphone.width * 0.2,
                                        child: Hero(
                                          tag: list[i].url,
                                          child: Image.asset(
                                            list[i].icon,
                                          ),
                                        ),
                                      ),
                                      footer: GridTileBar(
                                        title: Container(
                                          height: sizedphone.height * 0.04,
                                          // width: sizedphone.width*0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.8)),
                                          child: Center(
                                            child: Text(
                                              list[i].lebel,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    child: Text(language['logout']),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AuthScreen.routeName);
                      Provider.of<Auth>(context, listen: false).logout();
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
                _connectionStatus.name != 'wifi'
                    ? Text(
                        language['Connect to wifi'],
                        style: Theme.of(context).textTheme.headline2,
                      )
                    : Provider.of<Respray>(context).isdoneserarching == false
                        ? ElevatedButton(
                            child: Text(language['Connect']),
                            onPressed: () async {
                              await Provider.of<Respray>(context, listen: false)
                                  .setisdoneserarching(true);
                              await Provider.of<Respray>(context, listen: false)
                                  .getIprespery();

                              Timer(Duration(seconds: 4), (() {
                                Navigator.of(context).pushReplacementNamed(
                                    ConnectScreen.routeName);
                              }));
                              Provider.of<Respray>(context, listen: false)
                                  .setisdoneserarching(false);
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(EdgeInsets.all(13)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))))
                        : Text(
                            language['wait for IP to find'],
                            style: Theme.of(context).textTheme.headline2,
                          ),
                ElevatedButton(
                    child: Text(language['Sync']),
                    onPressed: () {
                      Provider.of<Respray>(context, listen: false)
                          .sendudp('sync');
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
              ],
            )
          ],
        ));
  }

  Future<String> clickbuttongrid(
      BuildContext context,
      String lan,
      Map<dynamic, dynamic> language,
      bool state,
      String str1,
      String str2,
      String str3,
      String str4,
      String str5) async {
    if (state) {
      Provider.of<Respray>(context, listen: false).sendudp(str1);
      lan = language[str2];
     
    } else {
      Provider.of<Respray>(context, listen: false).sendudp(str3);
      lan = language[str4];
    
    }
    Timer(Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          language[str5] + ' ' + lan,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontWeight: FontWeight.normal),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    });
    return lan;
  }

  showLoaderDialog(BuildContext context) {
    Map language =
        Provider.of<Buttonclickp>(context, listen: false).languagepro;

    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text(language['wait for IP to find'])),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

 
}
