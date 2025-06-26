import 'dart:ui';

import 'package:get/get.dart';

class LocaleController extends GetxController {
  void changeLocale(String langCode) {
    var loc = Locale(langCode);
    Get.updateLocale(loc);
  }
}
