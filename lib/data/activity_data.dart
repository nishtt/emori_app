import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:mood_app/models/activity_item.dart';

// список всех категорий и активностей
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

  ActivityCategory(
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
      ActivityItem(
        key: 'cinema',
        icon: Icons.local_movies,
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

    ActivityCategory(
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

    ActivityCategory(
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

// поиск активности по ключу
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