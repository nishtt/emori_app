import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/main_theme.dart';
import '../themes/lavender_theme.dart';
import '../themes/bloom_theme.dart';
import '../themes/pink_theme.dart';
import '../themes/turqoise_theme.dart';
import '../themes/blue_theme.dart';
import '../themes/green_theme.dart';
import '../themes/peach_theme.dart';
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
    ThemeOption(name: "Light Cream", themeData: mainTheme, previewColor: const Color(0xFFF2F2E9)),
    ThemeOption(name: "Lavender Field", themeData: lavenderTheme, previewColor: const Color(0xFFD1C4E9)),
    ThemeOption(name: "Bloom", themeData: bloomTheme, previewColor: const Color.fromARGB(255, 197, 93, 97)),
    ThemeOption(name: "Pink Dream", themeData: pinkTheme, previewColor: const Color.fromARGB(255, 230, 199, 202)),
    ThemeOption(name: "Coral Shores", themeData: turqoiseTheme, previewColor: const Color.fromARGB(255, 248, 206, 166)),
    ThemeOption(name: "Sky Whisper", themeData: blueTheme, previewColor: const Color.fromARGB(255, 230, 199, 202)),
    ThemeOption(name: "Soft Moss", themeData: greenTheme, previewColor: const Color.fromARGB(255, 230, 199, 202)),
    ThemeOption(name: "Peach Garden", themeData: peachTheme, previewColor: const Color.fromARGB(255, 230, 199, 202)),
  ];

  ThemeData _themeData = mainTheme;
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