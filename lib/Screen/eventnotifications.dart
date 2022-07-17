import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:facemosque/Screen/signinScreen.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/messagefromtaipc.dart';
import 'package:facemosque/providers/messagesetting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              return GestureDetector(
                onTap: item.isEvent == 'false'
                    ? () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(language['delete Worning']),
                            content: Text(language['body delete worning']),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Provider.of<MessageSetting>(context,
                                          listen: false)
                                      .deleteNotification(item.eventId);
                                  Navigator.of(ctx).pop();
                                },
                                child: Text(language['yes']),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text(language['no']),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffD1B000), width: 3),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Container(
                    height: sizedphone.height * 0.1,
                    width: sizedphone.width * 0.9,
                    child: ListTile(
                      trailing: item.isEvent == 'true'
                          ? Container(
                              height: sizedphone.height * 0.04,
                              width: sizedphone.width * 0.3,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title:
                                                Text(language['sign Worning']),
                                            content: Text(
                                                language['body sign worning']),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pushNamed(
                                                      SigninScreen.routeName);
                                                },
                                                child: Text(language['yes']),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text(language['no']),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.qr_code_2,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text(
                                                language['delete Worning']),
                                            content: Text(language[
                                                'body delete worning']),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Provider.of<MessageSetting>(
                                                          context,
                                                          listen: false)
                                                      .deleteNotification(
                                                          item.eventId);
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text(language['yes']),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text(language['no']),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.delete_rounded)),
                                ],
                              ),
                            )
                          : null,
                      leading: Image.asset('assets/images/mosque.png'),
                      title: AutoSizeText(
                        item.title + ' ' + item.date,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(fontSize: 16),
                      ),
                      subtitle: AutoSizeText(
                        maxLines: 1,
                        item.message,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
