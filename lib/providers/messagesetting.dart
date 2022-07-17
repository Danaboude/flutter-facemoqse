import 'dart:convert';

import 'package:facemosque/providers/messagefromtaipc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageSetting with ChangeNotifier {
  List<MessageFromTaipc> messageFromTaipc = [];
  Future<void> getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    messageFromTaipc=[];

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
      messageFromTaipc.removeWhere((element) => element.eventId==eventId);
      prefs.setString('listmessage', MessageFromTaipc.encode(messageFromTaipc));
   
      notifyListeners();
    }
    
  


}
