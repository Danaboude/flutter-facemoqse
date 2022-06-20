import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buttonclickp with ChangeNotifier {
  int indexnavigationbar = 0;
  List<bool> sala = [false, false, false, false, false, false, false];
  int indextab = 0;
  Color colorw = Colors.grey;
  bool replacetoloc = true;
  bool languageselected = false;
  bool replacetoevent = true;
  Map<String, String> en = {
    'titlenamemasjed': 'Prayer and Iqamah times of mosque',
    'fajer': 'Fajer',
    'sharouq': 'Sharouq',
    'dhuhr': 'Dhuhr',
    'asr': 'Asr',
    'magrib': 'Magrib',
    'isha': 'Isha',
    'nextparer': 'Next Prayer After',
    'todayaya': 'Today\'s Aya',
    'mymosque': 'My Mosque',
    'searchmosquetimes': 'Search Mosque for Follow Prayer Times',
    'othermosque': 'Other Mosque',
    'followfronotific': 'Follow Mosques for Notifications',
    'eventnotifications': 'Event Notifications',
    'language': 'Language',
    'selectlanguage': 'Select Language',
    'englich': 'englich',
    'arabic': 'Arabic',
    'searchbar': 'Search for mosque...',
    'azannotification': 'Azen Notification'
    ,
    'adan': 'Adan',
    'prayer': 'prayer'
  };
  Map<String, String> ar = {
    'titlenamemasjed': 'مواقيات الصلاة والاقامة لجامع',
    'fajer': 'الفجر',
    'sharouq': 'الشروق',
    'dhuhr': 'الظهر',
    'asr': 'العصر',
    'magrib': 'المغرب',
    'isha': 'العشاء',
    'nextparer': 'الصلاة التالية بعد',
    'todayaya': 'اية اليوم',
    'mymosque': 'مسجدي',
    'searchmosquetimes': 'ابحث عن مسجد لتتبع اوقات الصلاة والاقام',
    'othermosque': 'مساجد اخرى',
    'followfronotific': 'اتبع المساجد للاشعارات',
    'eventnotifications': 'الاشعارات',
    'language': 'اللغة',
    'selectlanguage': 'اختيار اللغة',
    'englich': 'انكليزي',
    'arabic': 'عربي',
    'searchbar': 'ابحث عن مسجد',
    'azannotification': 'تنبهات الاذان',   'adan': 'الاذان',
    'prayer': 'الصلاة'
  };
  Map<String, String> get languagepro {
    return languageselected ? ar : en;
  }

  void readlanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('language'))
    languageselected = prefs.getBool('language')!;
    ;
    notifyListeners();
  }

  void selectlanguage(bool select) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageselected = select;
    prefs.setBool('language', languageselected);
    notifyListeners();
  }

  Future<void> getreplacetoloc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('replacetolocation') != null) {
      replacetoloc = prefs.getBool('replacetolocation')!;
    }
    // prefs.clear();

    notifyListeners();
  }

  Future<void> getreplacetoevent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('replacetoevent') != null) {
      replacetoevent = prefs.getBool('replacetoevent')!;
    }
    //  prefs.clear();

    notifyListeners();
  }

  void storereplacetoevent(bool? state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state != null) {
      prefs.remove('replacetoevent');
      prefs.setBool('replacetoevent', state);
      replacetoevent = state;
    }

    notifyListeners();
  }

  void storereplacetoloc(bool? state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state != null) {
      prefs.remove('replacetolocation');
      prefs.setBool('replacetolocation', state);
      replacetoloc = state;
    }

    notifyListeners();
  }

  void setindextab(int index) {
    indextab = index;
    notifyListeners();
  }

  void indexNavigationBar(int inde) {
    indexnavigationbar = inde;
    notifyListeners();
  }

  Future<void> storeDaysWeek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fajer', sala[0]);
    prefs.setBool('dhuhr', sala[1]);
    prefs.setBool('asr', sala[2]);
    prefs.setBool('magrib', sala[3]);
    prefs.setBool('isha', sala[4]);

    notifyListeners();
  }

  Future<void> readDaysWeek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('fajer')) {
      sala[0] = prefs.getBool('fajer')!;
      sala[1] = prefs.getBool(
        'dhuhr',
      )!;
      sala[2] = prefs.getBool(
        'asr',
      )!;
      sala[3] = prefs.getBool(
        'magrib',
      )!;
      sala[4] = prefs.getBool(
        'isha',
      )!;
    }

    notifyListeners();
  }

  void chackDayWeek(int id) {
    sala[id] == false ? sala[id] = true : sala[id] = false;
    notifyListeners();
  }
}
