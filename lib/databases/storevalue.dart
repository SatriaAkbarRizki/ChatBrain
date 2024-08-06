import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Storevalue {
  late final SharedPreferences prefs;
  bool isOpen = false;

  Future init() async => prefs = await SharedPreferences.getInstance();

  Future write(bool value) async {
    await init();
    await prefs.setBool('isOpen', value);

    log('Value from Write: ${prefs.getBool('isOpen').toString()}');
  }

  Future read() async {
    if (isOpen == false) await init();

    isOpen = prefs.getBool('isOpen')!;
    log('Value from read: ${isOpen.toString()}');
    return isOpen;
  }
}
