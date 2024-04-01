import 'dart:convert';

class MessageFromTaipc {
  String title;
  String message;
  String date;
  String time;
  String maxPerson;
  String mosqueid;
  String isEvent;
  String eventId;
  MessageFromTaipc({
    required this.maxPerson,
    required this.date,
    required this.eventId,
    required this.message,
    required this.title,
    required this.mosqueid,
    required this.time,
    required this.isEvent,
  });
  static String encode(List<MessageFromTaipc> messagefromtaipc) => json.encode(
        messagefromtaipc
            .map<Map<String, dynamic>>(
                (messagefromtaipc) => MessageFromTaipc.toMap(messagefromtaipc))
            .toList(),
      );
  static List<MessageFromTaipc> messageFromJson(String str) =>
      List<MessageFromTaipc>.from(
          json.decode(str).map((x) => MessageFromTaipc.fromJson(x)));

  static List<MessageFromTaipc> decode(String messagefromtaipc) =>
      (json.decode(messagefromtaipc) as List<dynamic>)
          .map<MessageFromTaipc>((item) => MessageFromTaipc.fromJson(item))
          .toList();

  static Map<String, dynamic> toMap(MessageFromTaipc messagefromtaipc) {
    return {
      'Title': messagefromtaipc.title,
      'Message': messagefromtaipc.message,
      'date': messagefromtaipc.date,
      'time': messagefromtaipc.time,
      'maxPerson': messagefromtaipc.maxPerson,
      'mosqueid': messagefromtaipc.mosqueid,
      'isEvent': messagefromtaipc.isEvent,
      'eventId': messagefromtaipc.eventId,
    };
  }

  factory MessageFromTaipc.fromJson(dynamic data) {
    return MessageFromTaipc(
      date: data['date'] ?? '',
      maxPerson: data['maxPerson'] ?? '',
      eventId: data['eventId'] ?? '',
      message: data['Message'] ?? '',
      title: data['Title'] ?? '',
      mosqueid: data['mosqueid'] ?? '',
      time: data['time'] ?? '',
      isEvent: data['isEvent'] ?? '',
    );
  }

  factory MessageFromTaipc.fromMap(Map<String, dynamic> map) {
    return MessageFromTaipc(
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      maxPerson: map['maxPerson'] ?? '',
      mosqueid: map['mosqueid'] ?? '',
      isEvent: map['isEvent'] ?? '',
      eventId: map['eventId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'MessageFromTaipc(title: $title, message: $message, date: $date, time: $time, maxPerson: $maxPerson, mosqueid: $mosqueid, isEvent: $isEvent, eventId: $eventId)';
  }

  String toStringRaw() {
    return 'MessageFromTaipc(title: $title, message: $message, date: $date, time: $time, maxPerson: $maxPerson, mosqueid: $mosqueid, isEvent: $isEvent, eventId: $eventId)';
  }
}
