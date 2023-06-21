import 'dart:ui';

import 'package:app2/lang/en_us.dart';
import 'package:app2/lang/zh_cn.dart';
import 'package:app2/main.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class LocalizationService extends Translations {
  // Default locale
  static final locale = Locale('zh', 'CN');

  static final fallbackLocale = Locale('en', 'US');

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'zh_CN': zhCN,
  };

  static Locale getLanguage() {
    if (getStoreLanguage() == LangType.CN) {
      return Locale('zh', 'CN');
    }

    return Locale('en', 'US');
  }

  static LangType getStoreLanguage() {
    if (box?.read(StoreBox.LANGUAGE) != null) {
      var language = box?.read(StoreBox.LANGUAGE);
      if (language == LangType.EN.toString()) {
        return LangType.EN;
      }
    }
    return LangType.CN;
  }

  static String getStoreLanguageString() {
    if (box?.read(StoreBox.LANGUAGE) != null) {
      var language = box?.read(StoreBox.LANGUAGE);
      if (language == LangType.EN.toString()) {
        return 'English';
      } else if (language == LangType.IN.toString()) {
        return 'Bahasa Indonesia';
      }
    }
    return '中文';
  }

  static setLanguage(LangType language) {
    print('language is null ??? : $language');
    switch (language) {
      case LangType.EN:
        Get.updateLocale(Locale('en', 'US'));
        box?.write(StoreBox.LANGUAGE, language.toString());
        break;
      case LangType.CN:
        Get.updateLocale(Locale('zh', 'CN'));
        box?.write(StoreBox.LANGUAGE, language.toString());
        break;
    }
  }
}
