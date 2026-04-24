import 'package:flutter/material.dart';
import '../services/mood_manager.dart'; 

class CalendarDayTile extends StatelessWidget {
  final int day;
  final bool isToday;
  final bool isFuture;
  final String? moodKey;
  final VoidCallback onTap;

  const CalendarDayTile({
    super.key,
    required this.day,
    required this.isToday,
    required this.isFuture,
    this.moodKey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isFuture ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    // 1. запись существует - показываем эмодзи
    if (moodKey != null) {
      return Image.asset(
        MoodManager.getAssetPath(moodKey!),
        width: 45,
        height: 45,
        fit: BoxFit.contain,
      );
    }

    // 2. сегодняшний день без записи 
    if (isToday) {
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.black, 
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          day.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
    }

    // 3. будущий день - неактивный
    if (isFuture) {
      return Text(
        day.toString(),
        style: const TextStyle(color: Colors.black12, fontSize: 14),
      );
    }

// 4. прошедший день без записи с плейсхолдером
    return Stack(
      alignment: Alignment.center, 
      children: [
        Image.asset(
          MoodManager.getPlaceholderPath(),
          width: 45, 
          height: 45,
          color: Color.fromARGB(89, 154, 154, 154), 
          fit: BoxFit.contain,
        ),
        Text(
          day.toString(),
          style: const TextStyle(
            color: Colors.grey, 
            fontSize: 14, 
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}