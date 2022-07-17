import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buttonclickp with ChangeNotifier {
  //int Specify which page to display if indexnavigationbottmbar = 0 it
  // show the home page and if  1 it show the favorite page.....
  int indexnavigationbottmbar = 0;
  //Turning off or on the adan alarm for every prayer as sala[0]  the fajer call to prayer
  List<bool> sala = [false, false, false, false, false, false, false];
  //var Specify the page to be displayed on My Mosque, Other Mosque.
  int indextab = 0;
  //Specify the page to be displayed on if true it well show Mosque and loction else  All Mosque
  bool replacetoloc = true;

  //Specify the page to be displayed on if true it well show just moque for event Mosque  else  All Mosque
  bool replacetoevent = true;
  // Language select key if true well make app arabic
  bool languageselected = false;
  //Two maps with the same keys with different values containing words in the language en,ar
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
    'azannotification': 'Azen Notification',
    'adan': 'Adan',
    'prayer': 'prayer',
    'delete Worning':'Delete Worning',
    'body delete worning':'Are you sure you want to Delete',
    'sign Worning':'Sign Worning',
    'body sign worning':'Are you sure you want to sign to Event',
    'yes':'Yes',
    'no':'No',
    'Register':'Register',
    'Cancel':'Cancel'
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
    'azannotification': 'تنبهات الاذان',
    'adan': 'الاذان',
    'prayer': 'الاقامة',
    'delete Worning':'تحذير حذف',
    'body delete worning':'هل أنت متأكد أنك تريد حذف',
    'sign Worning':'تحذير تسجيل',
    'body sign worning':'هل أنت متأكد أنك تريد تسجيل في الحدث',
    'yes':'نعم',
    'no':'لا',
    'Register':'تسجيل',
    'Cancel':'الغاء'
  };
  // A map that stores Arabic and English words according to the value of the variable languageselected
  Map<String, String> get languagepro {
    return languageselected ? ar : en;
  }

  //Update value of list sala to if user select Mosque
  // app well pass list<bool> true to put all alarm on
  void statesala(List<bool> s) {
    sala = s;
  }

  // read languagesselecet value from SharedPreferences Specifies in which language the
  // application will display when the application is closed and launched
  void readlanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('language'))
      languageselected = prefs.getBool('language')!;
//  make app listen to update values on Screen
    notifyListeners();
  }

// store languagesselecet value in SharedPreferences
  void storelanguage(bool select) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageselected = select;
    prefs.setBool('language', languageselected);
    notifyListeners();
  }

//get replacetoloc value from SharedPreferences
// To save whether it displays all the mosques or the selected mosque with locatoin  in the favorite page
  Future<void> getreplacetoloc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('replacetolocation') != null) {
      replacetoloc = prefs.getBool('replacetolocation')!;
    }
    notifyListeners();
  }

  //get replacetoloc value from SharedPreferences
// To save whether it displays all the mosques or the selected mosque for event in the favorite page
  Future<void> getreplacetoevent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('replacetoevent') != null) {
      replacetoevent = prefs.getBool('replacetoevent')!;
    }
    notifyListeners();
  }

// remove and store replacetoevent value in SharedPreferences and update replacetoevent value
  void storereplacetoevent(bool? state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state != null) {
      prefs.remove('replacetoevent');
      prefs.setBool('replacetoevent', state);
      replacetoevent = state;
    }
    notifyListeners();
  }

// remove and store replacetoloc value in SharedPreferences and update replacetoloc value
  void storereplacetoloc(bool? state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state != null) {
      prefs.remove('replacetolocation');
      prefs.setBool('replacetolocation', state);
      replacetoloc = state;
    }

    notifyListeners();
  }

// When the user click on My Mosque button well update indextab
  Future<void> setindextab(int index) async {
    indextab = index;
    notifyListeners();
  }

// When the user clicks any icon on ButtomNavigationBar well
// update indexnavigationbottmbar and show page according toindexnavigationbottmbar
  void indexNavigationBar(int inde) {
    indexnavigationbottmbar = inde;
    notifyListeners();
  }

  //store value of list sala in SharedPreferences  to save it
  // when the application is closed and launched
  Future<void> storesalaDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fajer', sala[0]);
    prefs.setBool('dhuhr', sala[1]);
    prefs.setBool('asr', sala[2]);
    prefs.setBool('magrib', sala[3]);
    prefs.setBool('isha', sala[4]);

    notifyListeners();
  }
  //read value of list sala from SharedPreferences

  Future<void> readsalaDay() async {
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

  //Update value of list sala like when make sala[0]= false (fajer) to not make alarm run(id mean index)
  void chackDayWeek(int id) {
    sala[id] == false ? sala[id] = true : sala[id] = false;
    notifyListeners();
  }
}
