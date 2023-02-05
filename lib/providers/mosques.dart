import 'dart:convert';

//Model Mosques
class Mosques {
  String mosqueid;
  String mac;
  String name;
  String countryid;
  String country;
  String idcity;
  String street;
  String houseno;
  String zip;
  String status;
  String publicip;
  String prymethod;
  String activationcode;
  String dateofstart;
  String Email;
  bool isFavrote;
  Mosques({
    required this.mosqueid,
    required this.mac,
    required this.name,
    required this.countryid,
    required this.country,
    required this.idcity,
    required this.street,
    required this.houseno,
    required this.zip,
    required this.status,
    required this.publicip,
    required this.prymethod,
    required this.activationcode,
    required this.dateofstart,
    required this.Email,
    this.isFavrote = false,
  });
  clean() {
    mosqueid = '';

    mac = '';
    name = '';
    countryid = '';
    country = '';
    idcity = '';
    street = '';
    houseno = '';
    zip = '';
    status = '';
    publicip = '';
    prymethod = '';
    activationcode = '';
    dateofstart = '';
    Email = '';
    isFavrote = false;
  }

  Map<String, dynamic> toMap() {
    return {
      'mosqueid': mosqueid,
      'mac': mac,
      'name': name,
      'countryid': countryid,
      'country': country,
      'idcity': idcity,
      'street': street,
      'house_no': houseno,
      'zip': zip,
      'status': status,
      'publicip': publicip,
      'prymethod': prymethod,
      'activationcode': activationcode,
      'dateofstart': dateofstart,
      'email': Email,
      'isFavrote': isFavrote,
    };
  }

  //factory mosques.fromJson(String source) => mosques.fromMap(json.decode(source));
  factory Mosques.fromJson(dynamic json) {
    return Mosques(
      mosqueid: json['mosque_id'] ?? '',
      mac: json['mac'] ?? '',
      name: json['name'] ?? '',
      countryid: json['country_id'] ?? '',
      country: json['country'] ?? '',
      idcity: json['id_city'] ?? '',
      street: json['street'] ?? '',
      houseno: json['house_no'] ?? '',
      zip: json['zip'] ?? '',
      status: json['status'] ?? '',
      publicip: json['public_ip'] ?? '',
      prymethod: json['pry_method'] ?? '',
      activationcode: json['activation_code'] ?? '',
      dateofstart: json['date_of_start'] ?? '',
      Email: json['email'] ?? '',
    );
  }

  @override
  String toString() {
    return '{mosqueid: $mosqueid, mac: $mac, name: $name, countryid: $countryid, country: $country, idcity: $idcity, street: $street, houseno: $houseno, zip: $zip, status: $status, publicip: $publicip, prymethod: $prymethod, activationcode: $activationcode, dateofstart: $dateofstart}';
  }

  factory Mosques.fromMap(Map<String, dynamic> map) {
    return Mosques(
      mosqueid: map['mosqueid'] ?? '',
      mac: map['mac'] ?? '',
      name: map['name'] ?? '',
      countryid: map['countryid'] ?? '',
      country: map['country'] ?? '',
      idcity: map['idcity'] ?? '',
      street: map['street'] ?? '',
      houseno: map['house_no'] ?? '',
      zip: map['zip'] ?? '',
      status: map['status'] ?? '',
      publicip: map['publicip'] ?? '',
      prymethod: map['prymethod'] ?? '',
      activationcode: map['activationcode'] ?? '',
      dateofstart: map['dateofstart'] ?? '',
      Email: map['email'] ?? '',
      isFavrote: map['isFavrote'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
