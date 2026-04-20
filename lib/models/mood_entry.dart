import 'package:cloud_firestore/cloud_firestore.dart';

class MoodEntry {
  final String id;//id заметки
  final DateTime date;// дата заметки
  final String moodKey; // ключ настроения ('happy', 'sad' и тд)
  final int score;      // score настроения (1-5)
  final String note;   // текст заметки 

  MoodEntry({
    required this.id,
    required this.date,
    required this.moodKey,
    required this.score,
    required this.note,
  });

  //создаем запись из данных firestore
  factory MoodEntry.fromMap(Map<String, dynamic> data, String documentId) {
    return MoodEntry(
      id: documentId,
      date: (data['date'] as Timestamp).toDate(),
      moodKey: data['moodKey'] ?? 'neutral',
      score: data['score'] ?? 3,
      note: data['note'] ?? '',
    );
  }

  // конвертируем запись в map для firestore
  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'moodKey': moodKey,
      'score': score,
      'note': note,
    };
  }
}