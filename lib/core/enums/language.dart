import 'dart:ui';

enum Language {
  english(Locale('en', 'US')),
  arabic(Locale('ar', 'US'));

  final Locale locale;

  const Language(this.locale);
}
