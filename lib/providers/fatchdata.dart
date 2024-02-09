import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:mapbox_api/mapbox_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:facemosque/providers/mosque.dart';
import 'package:facemosque/providers/mosques.dart';
import 'package:geocoder_location/geocoder.dart';

import 'package:latlong2/latlong.dart' as latlong;

class FatchData with ChangeNotifier {
  //make object of Model Mosque to store Mosques form api Mosque
  // dart has null safty so i most give initzial value
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
  //list  of Mosques to store Mosques form api
  List<Mosques> mosquelist = [];
  //make object of Model Mosques to store The chosen mosque
  Mosques mosqueFollow = Mosques(
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
      dateofstart: '',
      Email: '',
      isFavrote: false);
  // Latlng are the coordinates to show a location on the map
  latlong.LatLng latlng1 = latlong.LatLng(0, 0);
//store star state (true,false) in SharedPreferences
  Mosques mosqueFollowevent = Mosques(
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
      dateofstart: '',
      Email: '',
      isFavrote: false);
  // store mosqueFollow.isFavrote value in SharedPreferences
  // if it true that mean mosque select for fatch data mousqe
  Future<void> setmosqueFollowFavrote(bool val) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    mosqueFollow.isFavrote = val;
    preferences.setBool('favortemosqe', val);
    notifyListeners();
  }

// ask for location Permisson
  void locationPermission() async {
    if (!kIsWeb) {
      final location = Location();
      final hasPermissions = await location.hasPermission();
      if (hasPermissions != PermissionStatus.granted) {
        await location.requestPermission();
      }
    }
  }

// get LatLng from address using MapboxApi becuse FlutterMap Requires LatLng for Markars
  Future<void> loction() async {
    try {
      print("-->Mosque" + mosqueFollow.Email);
      if (mosqueFollow.street != '') {
        MapboxApi mapbox = MapboxApi(
          accessToken:
              'pk.eyJ1IjoiZmFjZW1vc3F1ZSIsImEiOiJja2dwOTVkdzQwM21hMnZzMjQ1amJhaWxmIn0.fqW1E4WO3RSMu3tAPkz25g',
        );
        final GeocodingApiResponse response =
            await mapbox.forwardGeocoding.request(
          searchText: '${mosqueFollow.street}. ${mosqueFollow.houseno}',
          fuzzyMatch: true,
          language: 'en',
        );
        latlng1 = latlong.LatLng(
            response.features![1].center![1], response.features![1].center![0]);
        notifyListeners();
      }
    } catch (e) {}
  }

// Search in mosquelist for mosque
  Future<void> Searchval(String val) async {
    final a = mosquelist.where((element) {
      final namemosq = element.name.toLowerCase();
      final input = val.toLowerCase();
      return namemosq.contains(input);
    }).toList();
    if (val == '') fatchandsetallmosque();

    mosquelist = a;
    notifyListeners();
  }

// fatch all mousqe from api
  Future<void> fatchandsetallmosque() async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://facemosque.eu/api/api.php?client=app&cmd=mosquelist",
        ),
        headers: {
          "Connection": "Keep-Alive",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (kDebugMode) {
        print(response.body);
      }
      /*Iterable l = json.decode(
          "${response.body.split('\n').toString().substring(0, response.body.split('\n').toString().length - 3)}]");*/
      Iterable l = json.decode(response.body);

      mosquelist =
          List<Mosques>.from(l.map((model) => Mosques.fromJson(model)));
      if (kDebugMode) {
        print(response.body);
      }
      for (var mosqueli in mosquelist) {
        if (kDebugMode) {
          print(mosqueli.Email);
        }
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

//read data form SharedPreferences I used when app lanched to make app run offline
  Future<void> readdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      if (preferences.containsKey('mosque')) {
        mosque = Mosque.fromJson(json.decode(preferences.getString('mosque')!));
      }
      if (preferences.containsKey('mosqueFollow')) {
        mosqueFollow = Mosques.fromJson(
            json.decode(preferences.getString('mosqueFollow')!));
        Timer.periodic(const Duration(days: 1), (timer) {
          fatchandsetmosque(mosqueFollow.mosqueid);
          if (kDebugMode) {
            print(mosqueFollow);
          }
        });
        loction();

        //  fcmSubscribe(mosqueFollow.name);
      }
      if (preferences.containsKey('mosquesforevent')) {
        mosqueFollowevent = Mosques.fromJson(
            json.decode(preferences.getString('mosquesforevent')!));
        //  fcmSubscribe(mosqueFollow.name);
      }

      if (preferences.containsKey('favortemosqe')) {
        mosqueFollow.isFavrote = preferences.getBool('favortemosqe')!;
      }

      //logLongString(mosquelist.toString());
      // logLongString(mosque.toString());

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

//// fatch mousqe from api where id
  Future<void> fatchandsetmosque(String mosqid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('mosqid');
    try {
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
      if (kDebugMode) {
        print(jsonDecode(utf8.decode(response.bodyBytes)));
      }
      if (response.body == 'Mosque not exist') {
        mosqueFollow = mosquelist.firstWhere(
            (element) => int.parse(element.mosqueid) == int.parse(mosqid));
        prefs.setString('mosqueFollow', json.encode(mosqueFollow.toMap()));
        prefs.setString('mosqid', mosqid);
      } else {
        var data = utf8.decode(response.bodyBytes);
        Mosque mosqu = await Mosque.fromJson(jsonDecode(data));
        mosqueFollow = mosquelist.firstWhere(
            (element) => int.parse(element.mosqueid) == int.parse(mosqid));
        prefs.setString('mosqueFollow', json.encode(mosqueFollow.toMap()));
        prefs.remove('mosque');
        // print(json.encode(mosqu.toMap()));
        prefs.setString('mosque', json.encode(mosqu.toMap()));
        mosquelist.removeWhere(
            (element) => element.mosqueid == mosqueFollow.mosqueid);
        mosquelist.removeWhere(
            (element) => element.mosqueid == mosqueFollowevent.mosqueid);
        prefs.setString('mosqid', mosqid);
      }
      notifyListeners();
      // logLongString(mosque.toString());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //Delete Mosque form SharedPreferences
  Future<void> cleandata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
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
      prefs.remove('mosqueFollow');
      mosqueFollow.clean();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

// to print long String like all mousqe
  void logLongString(String s) {
    if (s.isEmpty || s.length <= 0) return;
    const int n = 1000;
    int startIndex = 0;
    int endIndex = n;
    while (startIndex < s.length) {
      if (endIndex > s.length) endIndex = s.length;
      if (kDebugMode) {
        print(s.substring(startIndex, endIndex));
      }
      startIndex += n;
      endIndex = startIndex + n;
    }
  }
}
