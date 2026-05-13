import 'package:flutter/material.dart';

class AppTheme {
  final String id;//ключ темы, например 'pink'
  final String name;//название темы
  final ThemeData themeData;//набор цветов для темы

  const AppTheme({
    required this.id,
    required this.name,
    required this.themeData,
  });
}
