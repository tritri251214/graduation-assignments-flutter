import 'package:flutter/material.dart';

class NullText extends StatelessWidget {
  const NullText({super.key, required this.text, this.style = const TextStyle()});

  final String? text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return text != null && text != '' ? Text(text!, style: style) : Text('__ __ __', style: style);
  }
}
