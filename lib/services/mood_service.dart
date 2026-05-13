import 'package:flutter/material.dart';

import 'package:mood_app/data/mood_data.dart';
import 'package:mood_app/l10n/app_localizations.dart';

class MoodManager {
  static List<String> get moodKeys => moodKeysData;

  static int getScore(String moodKey) {
    return moodScores[moodKey] ?? 3;
  }

  static String getTranslation(BuildContext context, String moodKey) {
    final l10n = AppLocalizations.of(context);

    if (l10n == null) return moodKey;

    switch (moodKey.toLowerCase()) {
      case 'happy':
        return l10n.happy;
      case 'calm':
        return l10n.calm;
      case 'neutral':
        return l10n.neutral;
      case 'lost':
        return l10n.lost;
      case 'tired':
        return l10n.tired;
      case 'anxious':
        return l10n.anxious;
      case 'sad':
        return l10n.sad;
      case 'angry':
        return l10n.angry;
      default:
        return moodKey;
    }
  }
}