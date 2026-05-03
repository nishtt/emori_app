import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mood_app/data/mood_packs.dart';
import 'package:mood_app/models/mood_pack.dart';

class MoodPackProvider extends ChangeNotifier {
  static const _key = 'selected_mood_pack_id';

  MoodPack _currentPack = moodPacks.first;

  MoodPack get currentPack => _currentPack;

  List<MoodPack> get packs => moodPacks;

  // смена пака
  Future<void> setPack(MoodPack pack) async {
    _currentPack = pack;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, pack.id);
  }

  // загрузка сохранённого пака
  Future<void> loadPack() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString(_key);

    if (savedId == null) return;

    _currentPack = moodPacks.firstWhere(
      (p) => p.id == savedId,
      orElse: () => moodPacks.first,
    );

    notifyListeners();
  }

  String getAssetPath(String moodKey) {
    return '${_currentPack.basePath}$moodKey.webp';
  }

  // placeholder (если нет данных)
  String getPlaceholderPath() {
    return '${_currentPack.basePath}${_currentPack.placeholder}';
  }
}