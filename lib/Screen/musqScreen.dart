import 'dart:convert';

import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosques.dart';
import 'package:facemosque/widget/loctionmosque.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/notificationHelper.dart';

class MusqScreen extends StatefulWidget {
  const MusqScreen({Key? key}) : super(key: key);

  @override
  State<MusqScreen> createState() => _MusqScreenState();
}

class _MusqScreenState extends State<MusqScreen> with TickerProviderStateMixin {
  NotificationHelper _notificationHelper = NotificationHelper();

  late mosques mosquesforevent;
  late mosques mosquefollow;
  @override
  Widget build(BuildContext context) {
    mosquefollow = Provider.of<FatchData>(context, listen: false).mosqueFollow;
    mosquesforevent = Provider.of<FatchData>(context).mosqueFollowevent;

    Map language = Provider.of<Buttonclickp>(context).languagepro;

    var sizedphone = MediaQuery.of(context).size;
    var listmosque = Provider.of<FatchData>(context).mosquelist;
    // var listmosqueother = Provider.of<FatchData>(context).mosquelist;
    //print(mosques.isFavrote);
    // mosquefollow.isFavrote = true;
    mosquesforevent.isFavrote = true;

    // print(listmosque);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: sizedphone.height * 0.06,
                width: sizedphone.width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Text(
                        language['mymosque'],
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(fontSize: 16),
                      ),
                      onTap: () {
                        Provider.of<Buttonclickp>(context, listen: false)
                            .setindextab(0);
                      },
                    ),
                    InkWell(
                      child: Text(
                        language['othermosque'],
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(fontSize: 16),
                      ),
                      onTap: () {
                        Provider.of<Buttonclickp>(context, listen: false)
                            .setindextab(1);
                      },
                    )
                  ],
                )),
            Provider.of<Buttonclickp>(context).indextab == 0
                ? Provider.of<Buttonclickp>(context).replacetoloc
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
                              title: Text(
                                mosquefollow.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(fontSize: 16),
                              ),
                              subtitle: Text(
                                '${mosquefollow.country} , ${mosquefollow.street}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      mosquefollow.isFavrote =
                                          !mosquefollow.isFavrote;
                                    });
                                    Provider.of<FatchData>(context,
                                            listen: false)
                                        .setisFavrote(false);

                                    Provider.of<Buttonclickp>(context,
                                            listen: false)
                                        .storereplacetoloc(true);
                                    listmosque.removeWhere(
                                        (element) => element.isFavrote = true);
                                    Provider.of<FatchData>(context,
                                            listen: false)
                                        .cleandata();
                                    Provider.of<FatchData>(context,
                                            listen: false)
                                        .fatchandsetallmosque();
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: mosquefollow.isFavrote
                                        ? const Color(0xFFd4af37)
                                        : Colors.grey,
                                  )),
                            ),
                          ),
                        ],
                      )
                : Provider.of<Buttonclickp>(context).replacetoevent
                    ? masqveiw(sizedphone, context, listmosque, false)
                    : Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffD1B000), width: 3),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: ListTile(
                          leading: Image.asset('assets/images/mosque.png'),
                          title: Text(
                            mosquesforevent.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(fontSize: 16),
                          ),
                          subtitle: Text(
                            '${mosquesforevent.country} , ${mosquesforevent.street}',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(
                                    fontSize: 8, fontWeight: FontWeight.normal),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  _notificationHelper.cancelAll();
                                  mosquesforevent.isFavrote =
                                      !mosquesforevent.isFavrote;
                                });
                                Provider.of<Buttonclickp>(context,
                                        listen: false)
                                    .storereplacetoevent(true);
                                Provider.of<FatchData>(context, listen: false)
                                    .fatchandsetallmosque();
                              },
                              icon: Icon(
                                Icons.star,
                                color: mosquesforevent.isFavrote
                                    ? const Color(0xFFd4af37)
                                    : Colors.grey,
                              )),
                        ),
                      )
          ],
        ),
      ),
    );
  }

  Column masqveiw(Size sizedphone, BuildContext con, List<mosques> listmosque,
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
              Provider.of<FatchData>(con, listen: false).seachval(value);
            },
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              filled: false,

              fillColor: Colors.black,
              // iconColor: Colors.black,
              focusColor: Colors.grey,
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
                              if (mymusque) {
                                Provider.of<Buttonclickp>(con, listen: false)
                                    .storereplacetoloc(false);
                                setState(() {
                                  item.isFavrote = !item.isFavrote;
                                });
                                                                


                                mosquefollow = listmosque.firstWhere(
                                    (element) =>
                                        element.mosqueid == item.mosqueid);

                                await Provider.of<FatchData>(con, listen: false)
                                    .fatchandsetmosque(mosquefollow.mosqueid);
                                await Provider.of<FatchData>(con, listen: false)
                                    .readdata();
                                    Provider.of<FatchData>(context,listen: false).setisFavrote(true);
                              } else {
                                Provider.of<Buttonclickp>(con, listen: false)
                                    .storereplacetoevent(false);

                                setState(() {
                                  item.isFavrote = !item.isFavrote;
                                });

                                mosquesforevent = listmosque.firstWhere(
                                    (element) =>
                                        element.mosqueid == item.mosqueid);
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString('mosquesforevent',
                                    json.encode(mosquesforevent.toMap()));
                                await Provider.of<FatchData>(con, listen: false)
                                    .readdata();
                              }
                            },
                            icon: Icon(
                              Icons.star,
                              color: Colors.grey,
                            )),
                        leading: Image.asset('assets/images/mosque.png'),
                        title: Text(
                          item.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontSize: 16),
                        ),
                        subtitle: Text(
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
}
