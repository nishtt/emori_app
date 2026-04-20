import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/light_mode.dart';
import '../themes/lavender_theme.dart';
import '../themes/bloom_theme.dart';
import '../themes/pink_theme.dart';
//модель для темы
class ThemeOption {
  final String name;
  final ThemeData themeData;
  final Color previewColor;

  ThemeOption({required this.name, required this.themeData, required this.previewColor});
}

class ThemeManager extends ChangeNotifier {
  // список всех доступных тем
  final List<ThemeOption> themeOptions = [
    ThemeOption(name: "Light Cream", themeData: LightMode, previewColor: const Color(0xFFF2F2E9)),
    ThemeOption(name: "Lavender", themeData: LavenderTheme, previewColor: const Color(0xFFD1C4E9)),
    ThemeOption(name: "Bloom", themeData: BloomTheme, previewColor: const Color.fromARGB(255, 197, 93, 97)),
    ThemeOption(name: "Pink Dream", themeData: PinkTheme, previewColor: const Color.fromARGB(255, 230, 199, 202)),
  ];

  ThemeData _themeData = LightMode;
  ThemeData get themeData => _themeData;

  // метод для смены темы по индексу
  void setTheme(int index) {
    _themeData = themeOptions[index].themeData;
    _saveTheme(index);
    notifyListeners();
  }

  // сохранение индекса выбранной темы
  Future<void> _saveTheme(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('selected_theme_index', index);
  }

  // загрузка сохраненной темы
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt('selected_theme_index') ?? 0;
    if (index < themeOptions.length) {
      _themeData = themeOptions[index].themeData;
      notifyListeners();
    }
  }
}