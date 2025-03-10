import 'package:flutter/material.dart';

enum TypeSnackBar {
  success,
  error,
  warning,
}

void showSnackBar(BuildContext context, Widget content, TypeSnackBar type) {
  Color backgroundColor = Colors.black;
  switch (type) {
    case TypeSnackBar.success:
      backgroundColor = Colors.green;
      break;
    case TypeSnackBar.error:
      backgroundColor = Colors.red;
      break;
    case TypeSnackBar.warning:
      backgroundColor = const Color.fromARGB(255, 211, 193, 39);
      break;
    }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      backgroundColor: backgroundColor,
      content: content,
      duration: const Duration(seconds: 5),
    ),
  );
}

void showNeedImplement(BuildContext context) {
  showSnackBar(context, const Text('The feature not implement!'), TypeSnackBar.warning);
}
