import 'package:flutter/material.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key, required this.text});

  final String text;

  @override
  State<LocationWidget> createState() => _LocationState();
}

class _LocationState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, size: 16),
        const SizedBox(width: 5),
        Text(
          widget.text,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
