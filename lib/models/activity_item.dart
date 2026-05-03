import 'package:flutter/material.dart';

class ActivityItem {
  final String key; // уникальный ключ активности
  final IconData icon; // иконка активности
  final String categoryKey; // ключ категории

  const ActivityItem({
    required this.key,
    required this.icon,
    required this.categoryKey,
  });
}

class ActivityCategory {
  final String key; // ключ категории
  final List<ActivityItem> items; // список активностей в категории

  const ActivityCategory({
    required this.key,
    required this.items,
  });
}