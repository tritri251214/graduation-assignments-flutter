import 'package:flutter_native_splash/flutter_native_splash.dart';

void initialization() async {
  await Future.delayed(const Duration(seconds: 10));
  FlutterNativeSplash.remove();
}
