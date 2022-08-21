import 'dart:convert';

import 'package:facemosque/providers/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:facemosque/providers/mosques.dart';

import 'data.dart';

class User {
  Mosques mosques;
  String email;
  String time_zone;
  String asr_method;
  User({
    required this.mosques,
    required this.email,
    required this.time_zone,
    required this.asr_method,
  });

  Map<String, dynamic> toMap() {
    return {
      'mosques': mosques.toMap(),
      'email': email,
      'time_zone': time_zone,
      'asr_method': asr_method,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      mosques: Mosques.fromMap(map['mosques']),
      email: map['email'] ?? '',
      time_zone: map['time_zone'] ?? '',
      asr_method: map['asr_method'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

class Auth with ChangeNotifier {
  bool chackuserinvide = false;

  User? user = null;

  void readuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      user = User.fromJson(prefs.getString('user')!);
    }
  }

  Future<void> register(String username, String first_n, String second_n,
      String password, String email, String date_of_birth, String mac) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://facemosque.eu/api/api.php?client=app&cmd=admin_reg&username=$username&first_name=$first_n&second_name=$second_n&password=$password &email=$email&date_of_birth=$date_of_birth&mac=$mac ",
        ),
        headers: {
          "Connection": "Keep-Alive",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.body.contains('mac')) {
        var userjosn = json.decode(response.body);
        user = User(
            mosques: Mosques(
                mosqueid: userjosn['mosque_id'],
                mac: userjosn['mac'],
                name: userjosn['name'],
                countryid: userjosn['country_id'],
                country: userjosn['country'],
                idcity: userjosn['id_city'],
                street: userjosn['street'],
                houseno: userjosn['house_no'],
                zip: userjosn['zip'],
                status: userjosn['public_ip'],
                publicip: userjosn['pry_method'],
                prymethod: userjosn['pry_method'],
                activationcode: userjosn['activation_code'],
                dateofstart: userjosn['time_zone']),
            email: userjosn['email'],
            time_zone: userjosn['date_of_start'],
            asr_method: userjosn['asr_method']);
        prefs.setString('user', json.encode(user!.toMap()));
      } else {
        throw HttpException(response.body.toString());
      }

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://facemosque.eu/api/api.php?client=app&cmd=admin_log&username=$username&password=$password",
        ),
        headers: {
          "Connection": "Keep-Alive",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.body.contains('mac')) {
        var userjosn = json.decode(response.body);
        user = User(
            mosques: Mosques(
                mosqueid: userjosn['mosque_id'],
                mac: userjosn['mac'],
                name: userjosn['name'],
                countryid: userjosn['country_id'],
                country: userjosn['country'],
                idcity: userjosn['id_city'],
                street: userjosn['street'],
                houseno: userjosn['house_no'],
                zip: userjosn['zip'],
                status: userjosn['public_ip'],
                publicip: userjosn['pry_method'],
                prymethod: userjosn['pry_method'],
                activationcode: userjosn['activation_code'],
                dateofstart: userjosn['time_zone']),
            email: userjosn['email'],
            time_zone: userjosn['date_of_start'],
            asr_method: userjosn['asr_method']);
        prefs.setString('user', json.encode(user!.toMap()));
      } else {
        throw HttpException(response.body.toString());
      }

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveMassge(String title, String massege,String time,String number,String date) async {

    
    try {
      http.Response response = await http.post(
        Uri.parse(
          "https://facemosque.eu/api/api.php?client=app&cmd=event_reg&mosque_id=${user!.mosques.mosqueid}&max_num=${number}&date=$date&time=${time}&event_name=$title",
        ),
        headers: {
          "Connection": "Keep-Alive",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print(response.body);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future sendtotaipc(String title, String massege, bool isEvent, String time,
      String date, String maxnum) async {
        
    saveMassge(title, massege,time,maxnum,date);
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    String toParams = "/topics/" + "${user!.mosques.name}";
    var data = Data('', '', '', time, '', false, 0, 0);
    if (!isEvent) {
      data.Title = title;
      data.date = '';
      data.time = '';
      data.isEvent = false;
      data.maxPerson = '';
      data.Message = '$massege (${user!.mosques.name})';
      data.setMosqueId = int.parse(user!.mosques.mosqueid);
      data.eventId = DateTime.now().millisecondsSinceEpoch;
      print(data.toString());
    } else {
      data.Title = title;
      data.date = date;
      data.time = time;
      data.isEvent = true;
      data.maxPerson = maxnum;
      data.Message = '$massege (${user!.mosques.name})';
      data.setMosqueId = int.parse(user!.mosques.mosqueid);
      data.eventId = DateTime.now().millisecondsSinceEpoch;
      print(data.toString());
    }

    var d = {
      'data': data.toMap(),
      "to": "${toParams}",
      "priority": "high",
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAVsDP8HM:APA91bFzAki2VdS-uqd7X_xRhpYvufymmRjUghFjz2e0CjZQtVNDWSgC8OP9sMdGoMpkZtFOaBlcfo3LonpI_pbFPaC0Yk8cdEP7lR6j-KQ94HzmzxhQffQB3uoG3HnrolzQfZ7d0LCB'
    };
    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(d),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      print("true");
    } else {
      print("false");
    }
  }

  Future<void> chackqr(String mobile) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          "https://facemosque.eu/api/api.php?client=app&cmd=qr_user_reg&m_num=$mobile",
        ),
        headers: {
          "Connection": "Keep-Alive",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.body == '"user is registered"')
        chackuserinvide = await true;
      else if (response.body == '"user is not registered"')
        chackuserinvide = await false;

      print(response.body);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');

    user = null;
  }
}
