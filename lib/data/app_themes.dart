import 'package:flutter/material.dart';

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
    previewColor: const Color(0xFFF2F2E9),
  ),
  AppTheme(
    id: 'lavender_field',
    name: 'Lavender Field',
    themeData: lavenderTheme,
    previewColor: const Color(0xFFD1C4E9),
  ),
  AppTheme(
    id: 'bloom',
    name: 'Bloom',
    themeData: bloomTheme,
    previewColor: const Color.fromARGB(255, 197, 93, 97),
  ),
  AppTheme(
    id: 'pink_dream',
    name: 'Pink Dream',
    themeData: pinkTheme,
    previewColor: const Color.fromARGB(255, 230, 199, 202),
  ),
  AppTheme(
    id: 'coral_shores',
    name: 'Coral Shores',
    themeData: turqoiseTheme,
    previewColor: const Color.fromARGB(255, 248, 206, 166),
  ),
  AppTheme(
    id: 'sky_whisper',
    name: 'Sky Whisper',
    themeData: blueTheme,
    previewColor: const Color.fromARGB(255, 170, 205, 232),
  ),
  AppTheme(
    id: 'soft_moss',
    name: 'Soft Moss',
    themeData: greenTheme,
    previewColor: const Color.fromARGB(255, 176, 207, 171),
  ),
  AppTheme(
    id: 'peach_garden',
    name: 'Peach Garden',
    themeData: peachTheme,
    previewColor: const Color.fromARGB(255, 244, 190, 160),
  ),
];