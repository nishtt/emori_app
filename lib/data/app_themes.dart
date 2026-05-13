
import 'package:mood_app/models/app_theme.dart';

import 'package:mood_app/themes/main_theme.dart';
import 'package:mood_app/themes/lavender_theme.dart';
import 'package:mood_app/themes/bloom_theme.dart';
import 'package:mood_app/themes/pink_theme.dart';
import 'package:mood_app/themes/turqoise_theme.dart';
import 'package:mood_app/themes/blue_theme.dart';
import 'package:mood_app/themes/green_theme.dart';
import 'package:mood_app/themes/peach_theme.dart';

// список всех доступных тем приложения
final List<AppTheme> appThemes = [
  AppTheme(
    id: 'light_cream',
    name: 'Light Cream',
    themeData: mainTheme,
  ),
  AppTheme(
    id: 'lavender_field',
    name: 'Lavender Field',
    themeData: lavenderTheme,
  ),
  AppTheme(
    id: 'bloom',
    name: 'Bloom',
    themeData: bloomTheme,
  ),
  AppTheme(
    id: 'pink_dream',
    name: 'Pink Dream',
    themeData: pinkTheme,
  ),
  AppTheme(
    id: 'coral_shores',
    name: 'Coral Shores',
    themeData: turqoiseTheme,
  ),
  AppTheme(
    id: 'sky_whisper',
    name: 'Sky Whisper',
    themeData: blueTheme,
  ),
  AppTheme(
    id: 'soft_moss',
    name: 'Soft Moss',
    themeData: greenTheme,
  ),
  AppTheme(
    id: 'peach_garden',
    name: 'Peach Garden',
    themeData: peachTheme,
  ),
];