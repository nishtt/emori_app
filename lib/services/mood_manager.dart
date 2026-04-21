import 'package:mood_app/themes/mood_themes.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MoodManager {

  static const List<String> moodKeys = [
    'happy', 'calm', 'neutral','lost','tired', 
    'anxious', 'sad', 'angry'
  ];

  static String getAssetPath(String moodKey) {
    return '${MoodThemes.selectedPack.basePath}$moodKey.webp';
  }
 
  static String getPlaceholderPath() {
    return '${MoodThemes.selectedPack.basePath}${MoodThemes.selectedPack.placeholder}';
  }
  
  static int getScore(String moodKey) {
    const scores = {
      'happy': 5, 'calm': 4, 'neutral': 3, 'lost': 2, 'tired': 2,
      'anxious': 2, 'sad': 1, 'angry': 1,
    };
    return scores[moodKey] ?? 3;
  }

  static String getTranslation(BuildContext context, String moodKey) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return moodKey;

    switch (moodKey.toLowerCase()) {
      case 'happy': return l10n.happy;
      case 'sad': return l10n.sad;
      case 'neutral': return l10n.neutral;
      case 'angry': return l10n.angry;
      case 'calm': return l10n.calm;
      case 'anxious': return l10n.anxious;  
      case 'tired': return l10n.tired;
      case 'lost': return l10n.lost;
      default: return moodKey;
    }
  }
}