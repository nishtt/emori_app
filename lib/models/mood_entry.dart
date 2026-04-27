import 'package:cloud_firestore/cloud_firestore.dart';

class MoodEntry {
  final String id;//id заметки
  final DateTime date;// дата заметки
  final String moodKey; // ключ настроения ('happy', 'sad' и тд)
  final int score;      // score настроения (1-5)
  final String note;   // текст заметки 
  final List<String> activities; // выбранные активности

  MoodEntry({
    required this.id,
    required this.date,
    required this.moodKey,
    required this.score,
    required this.note,
    this.activities = const [],
  });

  //создаем запись из данных firestore
  factory MoodEntry.fromMap(Map<String, dynamic> data, String documentId) {
    return MoodEntry(
      id: documentId,
      date: (data['date'] as Timestamp).toDate(),
      moodKey: data['moodKey'] ?? 'neutral',
      score: data['score'] ?? 3,
      note: data['note'] ?? '',
      activities: List<String>.from(data['activities'] ?? []),
    );
  }

  // конвертируем запись в map для firestore
  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'moodKey': moodKey,
      'score': score,
      'note': note,
      'activities': activities,
    };
  }

  MoodEntry copyWith({
    String? id,
    DateTime? date,
    String? moodKey,
    int? score,
    String? note,
    List<String>? activities,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      moodKey: moodKey ?? this.moodKey,
      score: score ?? this.score,
      note: note ?? this.note,
      activities: activities ?? this.activities,
    );
  }
}