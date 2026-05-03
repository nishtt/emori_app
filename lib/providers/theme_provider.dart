import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mood_app/data/app_themes.dart';
import 'package:mood_app/models/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'selected_theme_id';

  AppTheme _currentTheme = appThemes.first;

  // текущая выбранная тема
  AppTheme get currentTheme => _currentTheme;

  // ThemeData передаётся в MaterialApp
  ThemeData get themeData => _currentTheme.themeData;

  // список тем для экрана настроек
  List<AppTheme> get themes => appThemes;

  // смена темы по объекту AppTheme
  Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.id);
  }

  // смена темы по id
  Future<void> setThemeById(String id) async {
    final selectedTheme = appThemes.firstWhere(
      (theme) => theme.id == id,
      orElse: () => appThemes.first,
    );

    await setTheme(selectedTheme);
  }

  // загрузка сохранённой темы
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeId = prefs.getString(_themeKey);

    if (savedThemeId == null) {
      _currentTheme = appThemes.first;
      notifyListeners();
      return;
    }

    _currentTheme = appThemes.firstWhere(
      (theme) => theme.id == savedThemeId,
      orElse: () => appThemes.first,
    );

    notifyListeners();
  }
}