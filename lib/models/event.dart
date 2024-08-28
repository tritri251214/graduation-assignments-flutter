import 'dart:io';
import 'package:graduation_assignments_flutter/common/common.dart';
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
      id: int.parse(json['id'].toString()),
      name: json['name'].toString(),
      time: json['time'].toString(),
      location: json['location'].toString(),
      image: json['image'].toString(),
      price: double.parse(json['price'].toString()),
      favourite: bool.parse(json['favourite'].toString()),
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

  String getFromToTime() => '${customFormatTime(time, 'h:mm a')} - ${customFormatTime(timeEnd!, 'h:mm a')}';
}
