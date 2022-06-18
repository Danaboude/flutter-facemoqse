import 'dart:convert';

import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:facemosque/providers/mosques.dart';
import 'package:facemosque/widget/loctionmosque.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusqScreen extends StatefulWidget {
  const MusqScreen({Key? key}) : super(key: key);

  @override
  State<MusqScreen> createState() => _MusqScreenState();
}

class _MusqScreenState extends State<MusqScreen> with TickerProviderStateMixin {
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
    mosquefollow.isFavrote = true;
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
                      child: Text(language['mymosque']),
                      onTap: () {
                        Provider.of<Buttonclickp>(context, listen: false)
                            .setindextab(0);
                      },
                    ),
                    InkWell(
                      child: Text(language['othermosque']),
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
                              border: Border.all(color: Colors.grey, width: 2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.green,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(40),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF454545),
                                    //Color(0xFF57E9F2),
                                    Color(0xFF1ea345),
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(0.1, 0.7),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: ListTile(
                              leading: Image.asset('assets/images/mosque.png'),
                              title: Text(
                                mosquefollow.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  '${mosquefollow.country} , ${mosquefollow.street}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      mosquefollow.isFavrote =
                                          !mosquefollow.isFavrote;
                                    });
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
                                            color: const Color(0xffD1B000),
                                            width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.green,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(40),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFF454545),
                                //Color(0xFF57E9F2),
                                Color(0xFF1ea345),
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(0.1, 0.7),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: ListTile(
                          leading: Image.asset('assets/images/mosque.png'),
                          title: Text(
                            mosquesforevent.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '${mosquesforevent.country} , ${mosquesforevent.street}'),
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
            color: Color(0xFF1ea345),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(color: const Color(0xffD1B000), width: 3),
          ),
          child: TextField(
            onChanged: (value) {
              Provider.of<FatchData>(con, listen: false).seachval(value);
            },
            style: const TextStyle(color: Colors.white),
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
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.green,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xFF454545),
                              //Color(0xFF57E9F2),
                              Color(0xFF1ea345),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.1, 0.7),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${item.country} , ${item.street}'),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
