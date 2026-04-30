import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

final List<ActivityCategory> activityCategories = [
  const ActivityCategory(
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
        key: 'yoga',
        icon:Icons.self_improvement,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'water',
        icon: Icons.water_drop,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'healthy_food',
        icon: Icons.eco,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'medicine',
        icon: Icons.medication,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'good_sleep',
        icon: CupertinoIcons.moon_zzz,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'bad_sleep',
        icon: Icons.hotel,
        categoryKey: 'health',
      ),      
      ActivityItem(
        key: 'early_wake',
        icon: Icons.alarm,
        categoryKey: 'health',
      ),
      ActivityItem(
        key: 'malaise',
        icon: Icons.sick,
        categoryKey: 'health',
      ),

    ],
  ),

    const ActivityCategory(
    key: 'bad_habits',
    items: [
      ActivityItem(
        key: 'junk_food',
        icon: Icons.fastfood,
        categoryKey: 'bad_habits',
      ),
      ActivityItem(
        key: 'alcohol',
        icon: Icons.local_bar,
        categoryKey: 'bad_habits',
      ),
      ActivityItem(
        key: 'smoking',
        icon: Icons.smoking_rooms,
        categoryKey: 'bad_habits',
      ),
      ActivityItem(
        key: 'doomscrolling',
        icon: Icons.phone_android,
        categoryKey: 'bad_habits',
      ),
      ActivityItem(
        key: 'caffeine',//caffeine.svg
        icon: Icons.coffee,
        categoryKey: 'bad_habits',
      ),
      ActivityItem(
        key: 'sugar',
        icon: Icons.cake,
        categoryKey: 'bad_habits',
      ),
      ActivityItem(
        key: 'skipped_meal',
        icon: Icons.no_meals,
        categoryKey: 'bad_habits',
      ),
      ActivityItem(
        key: 'staying_up_late',
        icon: Icons.nightlight,
        categoryKey: 'bad_habits',
      ),
      ActivityItem(
        key: 'water_shortage',
        icon: CupertinoIcons.drop_triangle,
        categoryKey: 'bad_habits',
      ),
    ],
  ),

  const ActivityCategory(
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
      ActivityItem(
        key: 'hot',
        icon: CupertinoIcons.thermometer_sun,
        categoryKey: 'weather',
      ),
      ActivityItem(
        key: 'cold',
        icon: CupertinoIcons.thermometer_snowflake,
        categoryKey: 'weather',
      ),
      ActivityItem(
        key: 'thunder', 
        icon: CupertinoIcons.cloud_bolt_fill,
        categoryKey: 'weather',
      ),
      ActivityItem(
        key: 'pressure',
        icon: CupertinoIcons.gauge,
        categoryKey: 'weather',
      ),
    ],
  ),

    const ActivityCategory(
    key: 'social_activity',
    items: [
      ActivityItem(
        key: 'friends',
        icon: CupertinoIcons.person_2,
        categoryKey: 'social_activity',
      ),
      ActivityItem(
        key: 'family',
        icon: Icons.family_restroom,
        categoryKey: 'social_activity',
      ),
      ActivityItem(
        key: 'pet',
        icon: Icons.pets,
        categoryKey: 'social_activity',
      ),
      ActivityItem(
        key: 'party', 
        icon: Icons.celebration,
        categoryKey: 'social_activity',
      ),
      ActivityItem(
        key: 'date',
        icon: CupertinoIcons.heart,
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


  const ActivityCategory(
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
      ActivityItem(
        key: 'cinema',
        icon: Icons.local_movies,
        categoryKey: 'hobbies',
      ),
    ],
  ),

  const ActivityCategory(
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
      ActivityItem(
        key: 'overwork',
        icon: Icons.battery_0_bar,
        categoryKey: 'work_study',
      ),
      ActivityItem(
        key: 'creative_block',
        icon: CupertinoIcons.lightbulb_slash,
        categoryKey: 'work_study',
      ),
      ActivityItem(
        key: 'procrastination',
        icon: Icons.hourglass_bottom,
        categoryKey: 'work_study',
      ),
      ActivityItem(
        key: 'late',
        icon: Icons.alarm,
        categoryKey: 'work_study',
      ),
      ActivityItem(
        key: 'presentation',
        icon: Icons.analytics_outlined,
        categoryKey: 'work_study',
      ),
    ],
  ),

const ActivityCategory(
    key: 'self_care',
    items: [
      ActivityItem(
        key: 'shopping',
        icon: Icons.shopping_cart,
        categoryKey: 'self_care',
      ),
      ActivityItem(
        key: 'beauty',
        icon: Icons.spa,
        categoryKey: 'self_care',
      ),
      ActivityItem(
        key: 'meditation',
        icon:Icons.self_improvement,
        categoryKey: 'self_care',
      ),
      ActivityItem(
        key: 'shower',
        icon: Icons.bathtub,
        categoryKey: 'self_care',
      ),
    ],
  ),

  const ActivityCategory(
    key: 'routine',
    items: [
      ActivityItem(
        key: 'cleaning',
        icon: Icons.cleaning_services,
        categoryKey: 'routine',
      ),
      ActivityItem(
        key: 'cooking',
        icon: Icons.soup_kitchen,
        categoryKey: 'routine',
      ),
      ActivityItem(
        key: 'washing',
        icon: Icons.local_laundry_service,
        categoryKey: 'routine',
      ),
      ActivityItem(
        key: 'gardening',
        icon: Icons.grass,
        categoryKey: 'routine',
      ),
      ActivityItem(
        key: 'driving',
        icon: Icons.directions_car,
        categoryKey: 'routine',
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
Widget buildActivityIcon(
  BuildContext context,
  ActivityItem activity, {
  double size = 26,
  Color? color,
}) {
  final iconColor = color ?? Theme.of(context).colorScheme.primary;

  return Icon(
    activity.icon,
    size: size,
    color: iconColor,
  );
}