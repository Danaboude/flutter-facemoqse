import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:facemosque/Screen/LanguageScreen.dart';
import 'package:facemosque/Screen/authscreen.dart';
import 'package:facemosque/Screen/azanScreen.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/buttonclick.dart';
import '../providers/respray.dart';

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
  ScanResult? scanResult;

  var _aspectTolerance = 0.00;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  @override
  Widget build(BuildContext context) {
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
          url: 'null',
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
                        "${language['Admin']} ${user.email}",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'IP ',
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
                                      if (list[i].url != 'null') {
                                        if (list[i].url == 'qr') {
                                          await _scan();
                                          if (scanResult!.rawContent != '') {
                                            Map a;
                                            if (json.decode(
                                                    scanResult!.rawContent)
                                                is Map) {
                                              a = json.decode(
                                                  scanResult!.rawContent);
                                            } else {
                                              a = {"Mobile Number": '1'};
                                            }
                                            print(a);
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
                                        } else {
                                          Navigator.of(context)
                                              .pushNamed(list[i].url);
                                        }
                                      } else {
                                        Provider.of<Respray>(context,
                                                listen: false)
                                            .sendudp('reboot');
                                            Timer(Duration(seconds: 2), (){
                                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          language['The restart command has been sent'],
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
                ElevatedButton(
                    child: Text(language['Connect']),
                    onPressed: () async {
                      await Provider.of<Respray>(context, listen: false)
                          .sendudp('ss');
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
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

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}
