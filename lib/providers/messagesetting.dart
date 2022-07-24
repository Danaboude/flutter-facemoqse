import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:facemosque/providers/messagefromtaipc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageSetting with ChangeNotifier {
  List<MessageFromTaipc> messageFromTaipc = [];


  Future<void> getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    messageFromTaipc = [];

    if (prefs.containsKey('listmessage')) {
      // final List<MessageFromTaipc> list = MessageFromTaipc.decode(prefs.getString('listmessage')!);
      final List<dynamic> jsonData =
          jsonDecode(prefs.getString('listmessage')!);
      messageFromTaipc = jsonData.map<MessageFromTaipc>((jsonList) {
        return MessageFromTaipc.fromJson(jsonList);
      }).toList();
      //   messageFromTaipc=list;

    }
    notifyListeners();
  }

  Future<void> deleteNotification(String eventId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    messageFromTaipc.removeWhere((element) => element.eventId == eventId);
    prefs.setString('listmessage', MessageFromTaipc.encode(messageFromTaipc));

    notifyListeners();
  }

  Future<void> senddatauserforevent(String fname, String lname, String number,
      MessageFromTaipc message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://facemosque.eu/api/api.php?client=app&cmd=user_reg&mosque_id=" +
              message.mosqueid +
              "&first_name=" +
              fname +
              "&last_name=" +
              lname +
              "&date=" +
              message.date +
              "&time=" +
              message.time +
              "&mobile_num=" +
              number,
        ),
        headers: {
          "Connection": "Keep-Alive",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var s="First Name: ${fname}  Last Name: ${lname} Mobile Number: ${number} Mosque Id: ${message.mosqueid } Date Event: ${message.date}";
        prefs.setString('${message.eventId}', s);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
