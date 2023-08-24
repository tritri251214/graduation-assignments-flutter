import 'package:graduation_assignments_flutter/utils/utils.dart';

class Event {
  int? id;
  String name;
  String time;
  String location;
  double price;
  String image;
  bool? favorite;

  Event({
    required this.name,
    required this.time,
    required this.image,
    required this.location,
    required this.favorite,
    required this.id,
    required this.price,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      name: json['name'].toString(),
      time: json['time'].toString(),
      location: json['location'].toString(),
      image: json['image'].toString(),
      price: json['price'] as double,
      favorite: json['favorite'] as bool,
    );
  }

  factory Event.newEvent() {
    return Event(
      name: '',
      time: '',
      location: '',
      image: '',
      price: 0,
      favorite: false,
      id: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toString(),
      'time': time.toString(),
      'location': location.toString(),
      'image': image.toString(),
      'price': price,
      'favorite': favorite,
    };
  }

  String getFormatTime() => formatTime(time);
}
