import 'package:flutter/material.dart';

class AppDimensions {
  AppDimensions._();

  static const rootPadding = 14.0;
  static BorderRadius cardBorderRadius = BorderRadius.circular(8.0);
  static BorderRadius imageCardBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0));
  static BorderRadius newBadgeBorderRadius = BorderRadius.circular(4.0);
  static BorderRadius imageListBorderRadius =
      const BorderRadius.all(Radius.circular(8.0));
  static BorderRadius borderButtonRadius = const BorderRadius.all(Radius.circular(10.0));
}
