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
  bool resetselected = false;
  bool themeselected = false;
  bool screenselected = false;
  bool languageformosqueselected = false;
  int counteraddparyer = 1;
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
    'englich': 'Englich',
    'arabic': 'Arabic',
    'searchbar': 'Search for mosque...',
    'azannotification': 'Azen Notification',
    'adan': 'Adan',
    'prayer': 'Prayer',
    'delete Worning': 'Delete Warning',
    'body delete worning': 'Are you sure you want to Delete',
    'sign Worning': 'Sign Warning',
    'body sign worning': 'Are you sure you want to sign to Event',
    'yes': 'Yes',
    'no': 'No',
    'Register': 'Register',
    'Cancel': 'Cancel',
    'username': 'User Name',
    'enterusername': 'Enter User Name',
    'firstname': 'First Name',
    'setyouname': 'set You\'r name',
    'lastname': 'Last name',
    'setyoulastname': 'set You\'r Last Name',
    'Password': 'Password',
    'passowrdisshort': 'Password is too short!',
    'Confirm Password': 'Confirm Password',
    'Password do not match!': 'Password do not match!',
    'Date of Brith YYYY-MM-DD': 'Date of Brith YYYY-MM-DD',
    'set You\'r Date': 'set You\'r Date',
    'E-mail': 'E-mail',
    'Invalid Email': 'Invalid Email',
    'set You\'r MAC': 'set You\'r MAC',
    'LOGIN': 'LOGIN',
    'SIGNUP': 'SIGNUP',
    'Event Noititcations': 'Event Notifications',
    'information': 'information',
    'Admin': 'Admin',
    'Title': 'Title',
    'fill TextFild': 'fill TextFild',
    'Event': 'Event',
    'SEND': 'SEND',
    'Success': 'Success',
    'You\'r Register Success': 'You\'r Register Success',
    'Erorr': 'Erorr',
    'Maximum number Persons': 'Maximum number Persons',
    'set Number': 'set Number',
    'Date of time': 'Date of time',
    'set a Time': 'set a Time',
    'Mosque Name': 'Mosque Name',
    'Mosque ID': 'Mosque ID',
    'Prauer_Method': 'Prayer_Method',
    'StatUs': 'StatUs',
    'Date Of Start': 'Date Of Start',
    'Actibation Code': 'Activation Code',
    'Address': 'Address',
    'Theme': 'Theme',
    'azan active': 'Azan Active',
    'azan': 'Azan',
    'Hijri': 'Hijri',
    'Adding Days': 'Adding Days',
    'Reboot': 'Reboot',
    'Black': 'Black',
    'White': 'White',
    'Reset': 'Reset',
    'Default': 'Default',
    'Reset Mode': 'Reset Mode',
    'Change Theme': 'Change Theme',
    'Select': 'Select',
    'Always On': 'Always On',
    'Change Screen Mode': 'Change Screen Mode',
    'Screen': 'Screen',
    'Scan QR Code': 'Scan QR Code',
    'Change Volume': 'Change Volume',
    'Mute': 'Mute',
    'volume': 'Volume',
    'Write Message': 'Write Message',
    'Send Message': 'Send Message',
    'Delete Message': 'Delete Message',
    'Message': 'Message',
    'Prayer Time': 'Prayer Time',
    'Prayer Settings': 'Prayer Settings',
    'Iqamah Settings': 'Iqamah Settings',
    'Chooses Time': 'Choose Time',
    'Chooses Prayer': 'Choose Prayer',
    'Chooses': 'Choose ',
    'Send Times': 'Send Time',
    'logout': 'Logout',
    'Connect': 'Connect',
    'Sync': 'Sync',
    'Scan': 'Scan',
    'not registered': 'Not Registered',
    'Back': 'Back',
    'Delete': 'Delete',
    'Share': 'Share',
    'An Error Occurred': 'An Error Occurred',
    'OK': 'OK',
    'Fill the TextFild': 'Fill the TextFild',
    'Wecome to Facemosque': 'Wecome to Facemosque',
    'Change Language': 'Change Language',
    'time of prayer has been updated': 'time of prayer has been updated',
    'please select Setting and prayer': 'please select Setting and prayer',
    'The restart command has been sent': 'The restart command has been sent',
    'Serach for Respray IP': 'Serach for Respray IP',
    'Choose ip': 'Choose ip',
    'wait for IP to find': 'Wait to find IP',
    'Connect to wifi': 'Connect to wifi',
    'No More paryer for today': 'No More paryer for today',
    'Today\'s prayers are over': 'Today\'s prayers are over',
    'Take me to Google Map': 'Take me to the mosque',
    'Select the mosque to see the last prayer':
        'Select the mosque to see the last prayer',
    'mosques': 'Mosques'
  };
  Map<String, String> ar = {
    'titlenamemasjed': 'مواقيت الصلاة و الإقامة لجامع',
    'fajer': 'الفجر',
    'sharouq': 'الشروق',
    'dhuhr': 'الظهر',
    'asr': 'العصر',
    'magrib': 'المغرب',
    'isha': 'العشاء',
    'nextparer': 'الصلاة التالية بعد',
    'todayaya': 'آية اليوم',
    'mymosque': 'مسجدي',
    'searchmosquetimes': 'ابحث عن مسجد لتتبع أوقات  الصلاة والإقامة',
    'othermosque': 'مساجد اخرى',
    'followfronotific': 'تبع المساجد للإشعارات',
    'eventnotifications': 'الإشعارات',
    'language': 'اللغة',
    'selectlanguage': 'اختيار اللغة',
    'englich': 'انكليزي',
    'arabic': 'عربي',
    'searchbar': 'ابحث عن مسجد',
    'azannotification': 'تنبهات الاذان',
    'adan': 'الأذان',
    'prayer': 'الإقامة',
    'delete Worning': 'تحذير حذف',
    'body delete worning': 'هل أنت متأكد أنك تريد حذف',
    'sign Worning': 'تحذير تسجيل',
    'body sign worning': 'هل أنت متأكد أنك تريد تسجيل في الحدث',
    'yes': 'نعم',
    'no': 'لا',
    'Register': 'تسجيل',
    'Cancel': 'الغاء',
    'username': 'اسم االمستخدم',
    'enterusername': 'ادخل اسم المستخدم',
    'firstname': 'الاسم الاول',
    'setyouname': 'ضع اسمك',
    'lastname': 'اللقب',
    'setyoulastname': 'ضع اسمك الأخير',
    'Password': 'كلمة المرور',
    'passowrdisshort': 'كلمة المرور قصيرة جدا!',
    'Confirm Password': 'تأكيد كلمة المرور',
    'Password do not match!': 'كلمة السر غير مطابقة!',
    'Date of Brith YYYY-MM-DD': 'تاريخ الميلاد YYYY-MM-DD',
    'set You\'r Date': 'حدد التاريخ',
    'E-mail': 'البريد الإلكتروني',
    'Invalid Email': 'بريد إلكتروني خاطئ',
    'set You\'r MAC': 'ضع MAC',
    'LOGIN': 'تسجيل الدخول',
    'SIGNUP': '  التسجيل حساب',
    'Event Noititcations': 'إشعارات الحدث',
    'information': 'معلومات',
    'Admin': 'مشرف',
    'Title': 'عنوان',
    'fill TextFild': 'ملء حقل النص',
    'Event': 'حدث',
    'SEND': 'إرسال',
    'Success': 'نجاح',
    'You\'r Register Success': 'قمت بتسجيل النجاح',
    'Erorr': 'خطأ',
    'Maximum number Persons': 'الحد الأقصى لعدد الأشخاص',
    'set Number': 'تعيين عدد',
    'Date of time': 'تاريخ الوقت',
    'set a Time': 'ضبط الوقت',
    'Mosque Name': 'اسم المسجد',
    'Mosque ID': 'رقم المسجد',
    'Prauer_Method': 'طريقة الصلاة',
    'StatUs': 'الحالة',
    'Date Of Start': 'تاريخ البدء',
    'Actibation Code': 'رمز التفعيل',
    'Address': 'عنوان',
    'Theme': 'مظهر',
    'azan active': 'نشط أذان',
    'azan': 'أذان',
    'Hijri': 'هجري',
    'Adding Days': 'إضافة أيام',
    'Reboot': 'اعادة التشغيل',
    'Black': 'أسود',
    'White': 'أبيض',
    'Default': 'إفتراضي',
    'Reset': 'إعادة ضبط',
    'Reset Mode': 'وضع إعادة التعيين',
    'Change Theme': 'تغير الخلفية الى اللون',
    'Select': 'اختيار',
    'Always On': 'دائما قيد التشغيل',
    'Change Screen Mode': 'تغيير وضع الشاشة',
    'Screen': 'شاشة',
    'Scan QR Code': ' QR مسح',
    'Change Volume': 'تغيير حجم الصوت',
    'Mute': 'صامت',
    'volume': 'الصوت',
    'Write Message': 'اكتب رسالة',
    'Send Message': 'أرسل رسالة',
    'Delete Message': 'حذف رسالة',
    'Message': 'رسالة',
    'Prayer Time': 'وقت الصلاة',
    'Prayer Settings': 'إعدادات الصلاة',
    'Iqamah Settings': 'إعدادات الإقامة',
    'Chooses Time': 'اختار الوقت',
    'Chooses Prayer': 'اختار الصلاة',
    'Chooses': 'اختار',
    'Send Times': 'إرسال الوقت',
    'logout': 'تسجيل خروج',
    'Connect': 'الاتصال',
    'Sync': 'مزامنة',
    'Scan': 'مسح',
    'not registered': 'لم يسجل',
    'Back': 'عودة',
    'Delete': 'حذف',
    'Share': 'شارك',
    'An Error Occurred': 'حدث خطأ',
    'OK': 'نعم',
    'Fill the TextFild': 'املأ حقل النص',
    'Wecome to Facemosque': 'Facemosque مرحبا بكم في ',
    'Change Language': 'تغيير لللغة',
    'time of prayer has been updated': 'تم تحديث وقت الصلاة',
    'please select Setting and prayer': 'يرجى تحديد الإعداد والصلاة',
    'The restart command has been sent': 'تم ارسال امر إعادة التشغيل',
    'Serach for Respray IP': 'ابحث عن Facemosque IP',
    'Choose ip': 'اختر IP',
    'wait for IP to find': 'IP انتظر حتى يتم العثور على',
    'Connect to wifi': 'wifi اتصل بشبكة',
    'No More paryer for today': 'لا مزيد من الصلاة لهذا اليوم',
    'Today\'s prayers are over': 'انتهت الصلوات لليوم',
    'Take me to Google Map': 'أرشدني إلى المسجد',
    'Select the mosque to see the last prayer': 'حدد الجامع لترى اخر توقيت صلاه'
  };

  String parerEdit = '';
  String settingEdit = '';
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

  void storetheme() async {
    themeselected = !themeselected;
    notifyListeners();
  }

  void setcunteraddparyer(int num) async {
    counteraddparyer = num;
    notifyListeners();
  }

  void setParerEdit(String str) async {
    parerEdit = str;
    notifyListeners();
  }

  void SetSettingEdit(String str) async {
    settingEdit = str;
    notifyListeners();
  }

  Future<void> storelanguageformosque() async {
    languageformosqueselected = !languageformosqueselected;
    notifyListeners();
  }

  Future<void> storereset() async {
    resetselected = !resetselected;
    notifyListeners();
  }

  void storeScreen() async {
    screenselected = !screenselected;
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
