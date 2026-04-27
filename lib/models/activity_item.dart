import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mood_app/l10n/app_localizations.dart';

class ActivityItem {
  final String key;
  final IconData icon;
  final String categoryKey;

  const ActivityItem({
    required this.key,
    required this.icon,
    required this.categoryKey,
  });
}

class ActivityCategory {
  final String key;
  final List<ActivityItem> items;

  const ActivityCategory({
    required this.key,
    required this.items,
  });
}

const List<ActivityCategory> activityCategories = [
  ActivityCategory(
    key: 'health',
    items: [
      ActivityItem(
        key: 'walk',
        icon: Icons.directions_walk,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'sport',
        icon: Icons.fitness_center,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'water',
        icon: Icons.water_drop,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'healthy_food',
        icon: Icons.restaurant,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'medicine',
        icon: Icons.medication,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'good_sleep',
        icon: Icons.hotel,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'bad_sleep',
        icon: Icons.bedtime_off,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'junk_food',
        icon: Icons.fastfood,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'alcohol',
        icon: Icons.local_bar,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'smoking',
        icon: Icons.smoking_rooms,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'doomscrolling',
        icon: Icons.phone_android,
        categoryKey: 'health',
      ),
    ],
  ),

  ActivityCategory(
    key: 'weather',
    items: [
      ActivityItem(
        key: 'sunny',
        icon: Icons.wb_sunny,
        categoryKey: 'weather',
      ),
      ActivityItem(
        key: 'rain',
        icon: CupertinoIcons.cloud_rain,
        categoryKey: 'weather',
      ),
      ActivityItem(
        key: 'cloudy',
        icon: Icons.cloud,
        categoryKey: 'weather',
      ),
      ActivityItem(
        key: 'snow',
        icon: Icons.ac_unit,
        categoryKey: 'weather',
      ),
      ActivityItem(
        key: 'windy',
        icon: CupertinoIcons.wind,
        categoryKey: 'weather',
      ),
    ],
  ),

    ActivityCategory(
    key: 'social_activity',
    items: [
      ActivityItem(
        key: 'friends',
        icon: CupertinoIcons.person_2,
        categoryKey: 'social_activity',
      ),
      ActivityItem(
        key: 'family',
        icon: CupertinoIcons.house,
        categoryKey: 'social_activity',
      ),
      ActivityItem(
        key: 'argument',
        icon: CupertinoIcons.exclamationmark_bubble,
        categoryKey: 'social_activity',
      ),
      ActivityItem(
        key: 'awkward_situation',
        icon: CupertinoIcons.hand_raised,
        categoryKey: 'social_activity',
      ),
      ActivityItem(
        key: 'staying_at_home',
        icon: CupertinoIcons.home,
        categoryKey: 'social_activity',
      ),
    ],
  ),


  ActivityCategory(
    key: 'hobbies',
    items: [
      ActivityItem(
        key: 'reading',
        icon: Icons.menu_book,
        categoryKey: 'hobbies',
      ),
      ActivityItem(
        key: 'music',
        icon: Icons.music_note,
        categoryKey: 'hobbies',
      ),
      ActivityItem(
        key: 'drawing',
        icon: Icons.brush,
        categoryKey: 'hobbies',
      ),
      ActivityItem(
        key: 'games',
        icon: Icons.sports_esports,
        categoryKey: 'hobbies',
      ),
    ],
  ),

  ActivityCategory(
    key: 'work_study',
    items: [
      ActivityItem(
        key: 'study',
        icon: Icons.school,
        categoryKey: 'work_study',
      ),
      ActivityItem(
        key: 'work',
        icon: Icons.work,
        categoryKey: 'work_study',
      ),
      ActivityItem(
        key: 'deadline',
        icon: Icons.timer,
        categoryKey: 'work_study',
      ),
      ActivityItem(
        key: 'meeting',
        icon: Icons.groups,
        categoryKey: 'work_study',
      ),
    ],
  ),



];

ActivityItem? getActivityByKey(String key) {
  for (final category in activityCategories) {
    for (final item in category.items) {
      if (item.key == key) {
        return item;
      }
    }
  }

  return null;
}
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
    case 'nap':
      return l10n.activity_nap;

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

    default:
      return key;
  }
}
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
    default:
      return key;
  }
}