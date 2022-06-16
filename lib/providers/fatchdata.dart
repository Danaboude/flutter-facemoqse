import 'dart:convert';

import 'package:facemosque/providers/mosque.dart';
import 'package:facemosque/providers/mosques.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FatchData with ChangeNotifier {
  Mosque mosque = Mosque(
      historicalevent: '',
      fajer: '',
      fajeri: '',
      sharouq: '',
      dhuhr: '',
      dhuhri: '',
      asr: '',
      asri: '',
      magrib: '',
      magribi: '',
      isha: '',
      ishai: '',
      friday_1: '',
      friday_2: '',
      horA: 0,
      qurane: '',
      qurana: '',
      haditha: '',
      hadithe: '',
      islamicevent: '',
      surhnum: '',
      ayanum: '',
      dataid: '');
  List<mosques> mosquelist = [];
  mosques mosqueFollow = mosques(
      mosqueid: '',
      mac: '',
      name: '',
      countryid: '',
      country: '',
      idcity: '',
      street: '',
      houseno: '',
      zip: '',
      status: '',
      publicip: '',
      prymethod: '',
      activationcode: '',
      dateofstart: '');
  // List<mosques> get mosquelist => _mosquelist;
  String namemosqs = '';
  mosques mosqueFollowevent = mosques(
      mosqueid: '',
      mac: '',
      name: '',
      countryid: '',
      country: '',
      idcity: '',
      street: '',
      houseno: '',
      zip: '',
      status: '',
      publicip: '',
      prymethod: '',
      activationcode: '',
      dateofstart: '');
  Future<void> seachval(String val) async {
    final a = mosquelist.where((element) {
      final namemosq = element.name.toLowerCase();
      final input = val.toLowerCase();
      return namemosq.contains(input);
    }).toList();
    mosquelist = a;
    notifyListeners();
    //  mosquelist.firstWhere((element){ if (element.name == val) {} });
  }

  Future<void> fatchandsetallmosque() async {
  //  SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://facemosque.eu/api/api.php?client=app&cmd=mosque_list&mosque",
        ),
        headers: {
          "Connection": "Keep-Alive",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );

      Iterable l = json.decode(
          "${response.body.split('\n').toString().substring(0, response.body.split('\n').toString().length - 3)}]");
      mosquelist =
          List<mosques>.from(l.map((model) => mosques.fromJson(model)));
     // prefs.remove('allmosque');

   //   prefs.setString('allmosque', json.encode(l));

      // logLongString(mosquelist.toString());

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> readdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      if (preferences.containsKey('mosque')) {
        mosque = Mosque.fromJson(json.decode(preferences.getString('mosque')!));
      }
      if (preferences.containsKey('mosqueFollow')) {
        mosqueFollow = mosques.fromJson(
            json.decode(preferences.getString('mosqueFollow')!));
      }
      if (preferences.containsKey('mosquesforevent')) {
        mosqueFollowevent = mosques.fromJson(
            json.decode(preferences.getString('mosquesforevent')!));
      }
      if (preferences.containsKey('namemosqs')) {
        namemosqs = preferences.getString('namemosqs')!;
      }
      //logLongString(mosquelist.toString());
      // logLongString(mosque.toString());

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fatchandsetmosque(String mosqid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // logLongString(mosque.toString());
    http.Response response = await http.get(
      Uri.parse(
        "https://facemosque.eu/api/api.php?client=app&cmd=get_database_method_time&mosque_id=$mosqid",
      ),
      headers: {
        "Connection": "Keep-Alive",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    //print(response.body);
    Mosque mosqu = Mosque.fromJson(json.decode(response.body));
    mosqueFollow = mosquelist.firstWhere(
        (element) => int.parse(element.mosqueid) == int.parse(mosqid));

    prefs.setString('mosqueFollow', json.encode(mosqueFollow.toMap()));
    namemosqs = mosqueFollow.name;
    prefs.setString('namemosqs', namemosqs);

    prefs.remove('mosque');
    prefs.setString('mosque', json.encode(mosqu.toMap()));
    mosquelist
        .removeWhere((element) => element.mosqueid == mosqueFollow.mosqueid);
    notifyListeners();

    try {} catch (e) {
      print(e);
    }
  }

  Future<void> cleandata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mosque = Mosque(
        historicalevent: '',
        fajer: '',
        fajeri: '',
        sharouq: '',
        dhuhr: '',
        dhuhri: '',
        asr: '',
        asri: '',
        magrib: '',
        magribi: '',
        isha: '',
        ishai: '',
        friday_1: '',
        friday_2: '',
        horA: 0,
        qurane: '',
        qurana: '',
        haditha: '',
        hadithe: '',
        islamicevent: '',
        surhnum: '',
        ayanum: '',
        dataid: '');
    prefs.remove('mosque');
    namemosqs = '';
    prefs.remove('namemosqs');
    notifyListeners();

    try {} catch (e) {
      print(e);
    }
  }

  void logLongString(String s) {
    if (s == null || s.length <= 0) return;
    const int n = 1000;
    int startIndex = 0;
    int endIndex = n;
    while (startIndex < s.length) {
      if (endIndex > s.length) endIndex = s.length;
      print(s.substring(startIndex, endIndex));
      startIndex += n;
      endIndex = startIndex + n;
    }
  }
}
