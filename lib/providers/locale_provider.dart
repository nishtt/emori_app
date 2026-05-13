import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  // по умолчанию русский
  Locale _locale = const Locale('ru');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale(); 
  }

  // метод для смены языка из настроек
  void setLocale(Locale locale) async {
    if (!['en', 'ru'].contains(locale.languageCode)) return;

    _locale = locale;
    notifyListeners(); 

    // сохраняем выбор в память телефона
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }

  // загрузка сохраненного языка из памяти
  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String languageCode = prefs.getString('language_code') ?? 'ru';
    _locale = Locale(languageCode);
    notifyListeners();
  }
}