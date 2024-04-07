import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:facemosque/Screen/signinScreenforevent.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/messagefromtaipc.dart';
import 'package:facemosque/providers/messagesetting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class EventNotifications extends StatefulWidget {
  const EventNotifications({Key? key}) : super(key: key);

  @override
  State<EventNotifications> createState() => _EventNotificationsState();
}

class _EventNotificationsState extends State<EventNotifications> {
  List<MessageFromTaipc> listmessage = [];
  Timer? t;
  @override
  void initState() {
    t = Timer.periodic(Duration(seconds: 1), (timer) {
      Provider.of<MessageSetting>(context, listen: false).getNotification();
    });
    super.initState();
  }

  @override
  void dispose() {
    t?.cancel();

    listmessage.clear();
    super.dispose();
  }

// todo: #8 fixing the way to show the notifications, the current method using timer to update @ibrahimalnasser
  @override
  Widget build(BuildContext context) {
    listmessage = Provider.of<MessageSetting>(context).messageFromTaipc;

    //call Map(languagepro) from provider (Buttonclickp) return en language as default
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    var sizedphone = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(

              // set color(icon app grean) form theme initlizt in main.dart
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(40)),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          child: Text(
            //show value(ar,en) of key eventnotifications
            language['eventnotifications'],
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Container(
          height: sizedphone.height * 0.73,
          width: sizedphone.width * 0.95,
          child: ListView(
            shrinkWrap: true,
            children: listmessage.map((item) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffD1B000), width: 3),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Container(
                  width: sizedphone.width * 0.9,
                  child: Column(children: [
                    ListTile(
                      enableFeedback: true,
                      leading: item.isEvent == 'false'
                          ? Image.asset('assets/images/announcement_0.png')
                          : Image.asset('assets/images/event-1.png'),
                      title: AutoSizeText(
                        item.title + ' ' + item.date,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(fontSize: 16),
                      ),
                      subtitle: AutoSizeText(
                        minFontSize: 14,
                        maxLines: 25,
                        item.message,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      //width: sizedphone.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    title: Text(language['delete Worning']),
                                    content:
                                        Text(language['body delete worning']),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Provider.of<MessageSetting>(context,
                                                  listen: false)
                                              .deleteNotification(item.eventId);
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text(language['yes']),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text(
                                          language['no'],
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(Icons.delete),
                              label: Text(language['Delete'])),
                          item.isEvent == 'true'
                              ? TextButton.icon(
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    if (!prefs.containsKey('${item.eventId}')) {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          title: Text(language['sign Worning']),
                                          content: Text(
                                              language['body sign worning']),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx)
                                                    .pushReplacementNamed(
                                                        SigninScreenforEvent
                                                            .routeName,
                                                        arguments: item);
                                              },
                                              child: Text(language['yes']),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text(
                                                language['no'],
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          title: Text('Qr Code'),
                                          content: Container(
                                            padding: EdgeInsets.only(left: 10),
                                            alignment: Alignment.center,
                                            height: sizedphone.height * 0.3,
                                            width: sizedphone.width * 0.7,
                                            child: QrImageView(
                                              data: prefs.getString(
                                                  '${item.eventId}')!,
                                              version: QrVersions.auto,
                                              size: 300.0,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextButton.icon(
                                                icon: const Icon(Icons
                                                    .arrow_forward_ios_sharp),
                                                onPressed: () async {
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  preferences
                                                      .remove('userinfo');

                                                  Navigator.of(ctx).pop();
                                                },
                                                label: Text(language['Back']),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.qr_code),
                                  label: Text('Qr'))
                              : Container(),
                          TextButton.icon(
                              onPressed: () {
                                Share.share(item.title +
                                    "\n" +
                                    item.message +
                                    "\n" +
                                    "Facemosuqe Team");
                              },
                              icon: Icon(Icons.share),
                              label: Text(language['Share'])),
                        ],
                      ),
                    )
                  ]),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

//ToDo