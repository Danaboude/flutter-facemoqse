import 'dart:convert';
//Model Mosque
class Mosque {
  String fajer;
  String fajeri;
  String sharouq;
  String dhuhr;
  String dhuhri;
  String asr;
  String asri;
  String magrib;
  String magribi;
  String isha;
  String ishai;
  String friday_1;
  String friday_2;
  int horA;
  String qurane;
  String qurana;
  String haditha;
  String hadithe;
  String islamicevent;
  String historicalevent;
  String surhnum;
  String ayanum;
  String dataid;
  Mosque({
    required this.historicalevent,
    required this.fajer,
    required this.fajeri,
    required this.sharouq,
    required this.dhuhr,
    required this.dhuhri,
    required this.asr,
    required this.asri,
    required this.magrib,
    required this.magribi,
    required this.isha,
    required this.ishai,
    required this.friday_1,
    required this.friday_2,
    required this.horA,
    required this.qurane,
    required this.qurana,
    required this.haditha,
    required this.hadithe,
    required this.islamicevent,
    required this.surhnum,
    required this.ayanum,
    required this.dataid,
  });
  factory Mosque.fromJson(Map<String, dynamic> json) {
    //print(json['Quran_A'].toString());
    if(json['Quran_A']!=null)
    {return Mosque(
        fajer: json['fajer']??'',
        fajeri: json['fajer_i']??'',
        sharouq: json['sharouq']??'',
        dhuhr: json['dhuhr']??'',
        dhuhri: json['dhuhr_i']??'',
        asr: json['asr']??'',
        asri: json['asr_i']??'',
        magrib: json['magrib']??'',
        magribi: json['magrib_i']??'',
        isha: json['isha']??'',
        ishai: json['isha_i']??'',
        friday_1: json['friday_1']??'',
        friday_2: json['friday_2']??'',
        horA: json['H_or_A']??0,
        qurane: json['Quran_E']??'',
        qurana: json['Quran_A']??'',
        haditha: json['Hadith_A']??'',
        hadithe: json['Hadith_E']??'',
        islamicevent: json['Islamic_event']??'',
       historicalevent:json['Historical_event']??'',
        surhnum: json['Surh_num']??'',
        ayanum: json['Aya_num']??'',
        dataid: json['date_id']??'');}
        else{
          return Mosque(
        fajer: json['fajer']??'',
        fajeri: json['fajeri']??'',
        sharouq: json['sharouq']??'',
        dhuhr: json['dhuhr']??'',
        dhuhri: json['dhuhri']??'',
        asr: json['asr']??'',
        asri: json['asri']??'',
        magrib: json['magrib']??'',
        magribi: json['magribi']??'',
        isha: json['isha']??'',
        ishai: json['ishai']??'',
        friday_1: json['friday_1']??'',
        friday_2: json['friday_2']??'',
        horA: json['horA']??0,
        qurane: json['qurane']??'',
        qurana: json['qurana']??'',
        haditha: json['haditha']??'',
        hadithe: json['hadithe']??'',
        islamicevent: json['islamicevent']??'',
       historicalevent:json['historicalevent']??'',
        surhnum: json['surhnum']??'',
        ayanum: json['ayanum']??'',
        dataid: json['dataid']??'');
        }
  }

  @override
  String toString() {
    return 'Mosque(fajer: $fajer, fajeri: $fajeri, sharouq: $sharouq, dhuhr: $dhuhr, dhuhri: $dhuhri, asr: $asr, asri: $asri, magrib: $magrib, magribi: $magribi, isha: $isha, ishai: $ishai, friday_1: $friday_1, friday_2: $friday_2, horA: $horA, qurane: $qurane, qurana: $qurana, haditha: $haditha, hadithe: $hadithe, islamicevent: $islamicevent, historicalevent: $historicalevent, surhnum: $surhnum, ayanum: $ayanum, dataid: $dataid)';
  }

  Map<String, dynamic> toMap() {
    return {
      'fajer': fajer,
      'fajeri': fajeri,
      'sharouq': sharouq,
      'dhuhr': dhuhr,
      'dhuhri': dhuhri,
      'asr': asr,
      'asri': asri,
      'magrib': magrib,
      'magribi': magribi,
      'isha': isha,
      'ishai': ishai,
      'friday_1': friday_1,
      'friday_2': friday_2,
      'horA': horA,
      'qurane': qurane,
      'qurana': qurana,
      'haditha': haditha,
      'hadithe': hadithe,
      'islamicevent': islamicevent,
      'historicalevent': historicalevent,
      'surhnum': surhnum,
      'ayanum': ayanum,
      'dataid': dataid,
    };
  }

  factory Mosque.fromMap(Map<String, dynamic> map) {
    return Mosque(
      fajer: map['fajer'] ?? '',
      fajeri: map['fajeri'] ?? '',
      sharouq: map['sharouq'] ?? '',
      dhuhr: map['dhuhr'] ?? '',
      dhuhri: map['dhuhri'] ?? '',
      asr: map['asr'] ?? '',
      asri: map['asri'] ?? '',
      magrib: map['magrib'] ?? '',
      magribi: map['magribi'] ?? '',
      isha: map['isha'] ?? '',
      ishai: map['ishai'] ?? '',
      friday_1: map['friday_1'] ?? '',
      friday_2: map['friday_2'] ?? '',
      horA: map['horA']?.toInt() ?? 0,
      qurane: map['qurane'] ?? '',
      qurana: map['qurana'] ?? '',
      haditha: map['haditha'] ?? '',
      hadithe: map['hadithe'] ?? '',
      islamicevent: map['islamicevent'] ?? '',
      historicalevent: map['historicalevent'] ?? '',
      surhnum: map['surhnum'] ?? '',
      ayanum: map['ayanum'] ?? '',
      dataid: map['dataid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

}
