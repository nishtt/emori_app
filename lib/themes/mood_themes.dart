import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_pack.dart';

class MoodThemes {
  static List<MoodPack> packs = [
    MoodPack(
      id: 'cats',
      name: 'Paper Cats',
      basePath: 'assets/packs/cats/',
      placeholder: 'empty_placeholder.webp',
    ),
    MoodPack(
      id: 'classic',
      name: 'Classic',
      basePath: 'assets/packs/classic/',
      placeholder: 'empty_placeholder.webp',
    ),

  ];

  static ValueNotifier<MoodPack> selectedPackNotifier = ValueNotifier(packs[0]);

  static MoodPack get selectedPack => selectedPackNotifier.value;

  // записываем id пака в память
  static Future<void> savePack(String packId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_mood_pack_id', packId);
  }

  // читаем id и устанавливаем нужный пак
  static Future<void> loadPack() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedId = prefs.getString('selected_mood_pack_id');

    if (savedId != null) {
      // ищем пак в списке
      final savedPack = packs.firstWhere(
        (p) => p.id == savedId,
        orElse: () => packs[0],
      );
      selectedPackNotifier.value = savedPack;
    }
  }
}