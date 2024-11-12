import 'dart:ui';
import 'package:get/get.dart';
import '../../di_container.dart';
import '../enums/language.dart';
import 'local_data_manager.dart';

LocaleService localeService = sl<LocaleService>();
LocalDataManager localDataManager = sl<LocalDataManager>();

class LocaleService {
  final LocalDataManager dataManager;

  LocaleService(this.dataManager);

  Locale get handleLocaleInMain {
    return getLocale().locale;
  }

  Language getLocale() {
    return dataManager.getLanguage ?? defaultLanguage;
  }

  Future<void> changeLocale(Language language) async {
    Get.updateLocale(language.locale);
    await dataManager.setLanguage(language);
  }

  Future<void> toggleLocale() async {
    if (!isArabic) {
      changeLocale(Language.arabic);
    } else {
      changeLocale(Language.english);
    }
  }

  Locale get defaultLocale => defaultLanguage.locale;

  Language get defaultLanguage => Language.values.first;

  bool get isArabic => Get.locale == Language.arabic.locale;
}
