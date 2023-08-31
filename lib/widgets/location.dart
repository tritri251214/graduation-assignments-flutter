import 'package:flutter/cupertino.dart';

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
        const Icon(CupertinoIcons.location, size: 16),
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
