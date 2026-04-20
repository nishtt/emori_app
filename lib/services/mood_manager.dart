import 'package:mood_app/themes/mood_themes.dart';

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
}