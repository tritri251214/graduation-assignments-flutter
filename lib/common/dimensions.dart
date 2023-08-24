import 'package:flutter/material.dart';

class AppDimensions {
  AppDimensions._();

  static const rootPadding = 14.0;
  static Color primaryColor = const Color(0xFF30D969);
  static Color white = Colors.white;
  static Color textColor = Colors.black;
  static Color iconBottomBarColor = const Color(0xFFBDBDBD);

  static BorderRadius cardBorderRadius = BorderRadius.circular(8.0);
  static Color backgroundCard = const Color(0xFFF2F2F2);
  static BorderRadius imageCardBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0));
  static BorderRadius newBadgeBorderRadius = BorderRadius.circular(4.0);
  static BorderRadius imageListBorderRadius =
      const BorderRadius.all(Radius.circular(8.0));
}
