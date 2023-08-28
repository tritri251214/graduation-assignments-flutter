import 'package:graduation_assignments_flutter/utils/utils.dart';

class Ticket {
  int? id;
  String title;
  String time;
  int numberOfTicket;
  String image;

  Ticket({
    required this.title,
    required this.time,
    required this.image,
    required this.numberOfTicket,
    this.id,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as int,
      title: json['title'].toString(),
      time: json['time'].toString(),
      numberOfTicket: json['numberOfTicket'],
      image: json['image'].toString(),
    );
  }

  factory Ticket.newTicket() {
    return Ticket(
      title: '',
      time: '',
      numberOfTicket: 0,
      image: '',
      id: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'numberOfTicket': numberOfTicket,
      'image': image,
    };
  }

  String getFormatTime() => formatTime(time);

  String getYear() => customFormatTime(time, 'yyyy');
}
