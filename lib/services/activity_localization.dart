import 'package:flutter/material.dart';
import 'package:mood_app/l10n/app_localizations.dart';

// локализованное название активности
String getActivityLabel(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context)!;

  switch (key) {
    case 'walk':
      return l10n.activity_walk;
    case 'sport':
      return l10n.activity_sport;
    case 'water':
      return l10n.activity_water;
    case 'medicine':
      return l10n.activity_medicine;
    case 'healthy_food':
      return l10n.activity_healthy_food;

    case 'good_sleep':
      return l10n.activity_good_sleep;
    case 'bad_sleep':
      return l10n.activity_bad_sleep;
    case 'early_wake':
      return l10n.activity_early_wake;
    case 'malaise':
      return l10n.activity_malaise;

    case 'sunny':
      return l10n.activity_sunny;
    case 'rain':
      return l10n.activity_rain;
    case 'cloudy':
      return l10n.activity_cloudy;
    case 'snow':
      return l10n.activity_snow;
    case 'windy':
      return l10n.activity_windy;

    case 'reading':
      return l10n.activity_reading;
    case 'music':
      return l10n.activity_music;
    case 'drawing':
      return l10n.activity_drawing;
    case 'games':
      return l10n.activity_games;

    case 'study':
      return l10n.activity_study;
    case 'work':
      return l10n.activity_work;
    case 'deadline':
      return l10n.activity_deadline;
    case 'meeting':
      return l10n.activity_meeting;

    case 'junk_food':
      return l10n.activity_junk_food;
    case 'alcohol':
      return l10n.activity_alcohol;
    case 'smoking':
      return l10n.activity_smoking;
    case 'doomscrolling':
      return l10n.activity_doomscrolling;
    
    case "friends":
      return l10n.activity_friends;
    case "family":
      return l10n.activity_family;
    case "argument":
      return l10n.activity_argument;
    case "awkward_situation":
      return l10n.activity_awkward_situation;
    case "staying_at_home":
      return l10n.activity_staying_at_home;
    case 'yoga':
      return l10n.activity_yoga;
    case 'caffeine':
      return l10n.activity_caffeine;
    case 'sugar':
      return l10n.activity_sugar;
    case 'skipped_meal':
      return l10n.activity_skipped_meal;
    case 'staying_up_late':
      return l10n.activity_staying_up_late;
    case 'water_shortage':
      return l10n.activity_water_shortage;
    case 'hot':
      return l10n.activity_hot;
    case 'cold':
      return l10n.activity_cold;
    case 'thunder':
      return l10n.activity_thunder;
    case 'pressure':
      return l10n.activity_pressure;
    case 'pet':
      return l10n.activity_pet;
    case 'party':
      return l10n.activity_party;
    case 'date':
      return l10n.activity_date;
    case 'cooking':
      return l10n.activity_cooking;
    case 'gardening':
      return l10n.activity_gardening;
    case 'cinema':
      return l10n.activity_cinema;
    case 'overwork':
      return l10n.activity_overwork;
    case 'creative_block':
      return l10n.activity_creative_block;
    case 'procrastination':
      return l10n.activity_procrastination;
    case 'late':
      return l10n.activity_late;
    case 'presentation':
      return l10n.activity_presentation;
    case 'shopping':
      return l10n.activity_shopping;
    case 'beauty':
      return l10n.activity_beauty;
    case 'meditation':
      return l10n.activity_meditation;
    case 'shower':
      return l10n.activity_shower;
    case 'cleaning':
      return l10n.activity_cleaning;
    case 'washing':
      return l10n.activity_washing;
    case 'driving':
      return l10n.activity_driving;

    default:
      return key;
  }
}

// локализованное название категории активности
String getActivityCategoryLabel(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context)!;

  switch (key) {
    case 'health':
      return l10n.health;
    case 'weather':
      return l10n.weather;
    case 'hobbies':
      return l10n.hobbies;
    case 'work_study':
      return l10n.work_or_study;
    case 'social_activity':
      return l10n.social_activity;
    case 'bad_habits':
      return l10n.bad_habits;
    case 'self_care':
      return l10n.self_care;
    case 'routine':
      return l10n.routine;
    default:
      return key;
  }
}