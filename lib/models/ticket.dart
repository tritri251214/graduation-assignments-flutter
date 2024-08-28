import 'dart:io';
import 'package:graduation_assignments_flutter/common/common.dart';
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

  String getImageUrl() {
    String imageUrl = '';
    try {
      if (Platform.isAndroid) {
        imageUrl = '${AppStrings.androidAPIBase}:${AppStrings.apiPort}/$image';
      } else if (Platform.isIOS) {
        imageUrl = '${AppStrings.iosAPIBase}:${AppStrings.apiPort}/$image';
      }
    } catch (e) {
      imageUrl = '${AppStrings.iosAPIBase}:${AppStrings.apiPort}/$image';
    }
    return imageUrl;
  }

  String getFormatTime() => formatTime(time);

  String getYear() => customFormatTime(time, 'yyyy');
}
