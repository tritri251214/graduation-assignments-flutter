import 'package:graduation_assignments_flutter/utils/utils.dart';

class Event {
  int? id;
  String name;
  String time;
  String location;
  double price;
  String image;
  bool? favourite;
  String? address;
  String? timeEnd;

  Event({
    required this.name,
    required this.time,
    required this.image,
    required this.location,
    required this.favourite,
    required this.id,
    required this.price,
    this.address,
    this.timeEnd,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      name: json['name'].toString(),
      time: json['time'].toString(),
      location: json['location'].toString(),
      image: json['image'].toString(),
      price: json['price'] as double,
      favourite: json['favourite'] as bool,
      address: json['address'].toString(),
      timeEnd: json['timeEnd'].toString(),
    );
  }

  factory Event.newEvent() {
    return Event(
      name: '',
      time: '',
      location: '',
      image: '',
      price: 0,
      favourite: false,
      id: null,
      address: '',
      timeEnd: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'location': location,
      'image': image,
      'price': price,
      'favourite': favourite,
      'address': address ?? '',
      'timeEnd': timeEnd ?? '',
    };
  }

  String getFormatTime() => formatTime(time);

  String getFromToTime() => '${customFormatTime(time, 'h:mm a')} - ${customFormatTime(timeEnd!, 'h:mm a')}';
}
