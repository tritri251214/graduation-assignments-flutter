// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppStorage extends GetxController {
  final storage = GetStorage('MyStorage');
  static init() async {
    await GetStorage.init('MyStorage');
  }

  static const profileNameKey = 'profile_name';

  String get profileName => storage.read(profileNameKey) ?? '';

  void setProfileName(String value) => storage.write(profileNameKey, value);

  void clearAll() => storage.erase();
}
