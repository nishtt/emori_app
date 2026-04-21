import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/mood_manager.dart';
import 'emote_picker_page.dart'; 
import 'package:mood_app/l10n/app_localizations.dart';


class CreateEntryPage extends StatefulWidget {
  final DateTime date;
  final String moodKey;
  final int score;
  final String? initialText;
  final bool isEditing;

  const CreateEntryPage({
    super.key,
    required this.date,
    required this.moodKey,
    required this.score,
    this.initialText,
    this.isEditing = false,
  });

  @override
  State<CreateEntryPage> createState() => _CreateEntryPageState();
}

class _CreateEntryPageState extends State<CreateEntryPage> {
  late TextEditingController _noteController;
  //переменные состояния
  late String _currentMoodKey;
  late int _currentScore;
  late bool _wasEdited;

  //инициализация переменных из виджета
  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialText ?? "");
    _currentMoodKey = widget.moodKey;
    _currentScore = widget.score;
    _wasEdited = widget.isEditing; 
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  //функция прехода к изменению эмодзи
  Future<void> _changeMood() async {
   
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmotePickerPage(selectedDate: widget.date, isReturningMode: true), // включен режим возврата
      ),
    );

    // если данные вернулись - обновляем состояние
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _currentMoodKey = result['moodKey'];
        _currentScore = result['score'];
        _wasEdited = true; // запись была отредактирована
      });
    }
  }

  //сохранение записи
  Future<void> _saveEntry() async {
    final user = FirebaseAuth.instance.currentUser;
    final l10n = AppLocalizations.of(context)!;
    if (user == null) return;

    try {
      String docId = DateFormat('yyyy-MM-dd').format(widget.date);

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('entries')
          .doc(docId)
          .set({
        'date': Timestamp.fromDate(widget.date),
        'moodKey': _currentMoodKey, 
        'score': _currentScore,     
        'note': _noteController.text.trim(),
      });

      if (mounted) {
        // возвращаемся в список записей после редактирования
        if (_wasEdited) { 
          Navigator.pop(context);
        } else {
          // возвращаемся в календарь
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.error}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            if (_wasEdited) {
              // после редактирования возвращаемся назад в список
              Navigator.pop(context);
            } else {
              //создали новую запись - к календарю
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: _saveEntry,
            child: Text(
              l10n.save,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //дата записи
                      Text(
                        DateFormat('E.', localeCode).format(widget.date),
                        style: const TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.w600, 
                          decoration: TextDecoration.underline
                        ),
                      ),
                      Text(
                        DateFormat('MM.dd').format(widget.date),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  //кликабельный эмодзи
                  Center(
                    child: GestureDetector(
                      onTap: _changeMood, // вызываем смену настроения
                      child: Tooltip(
                        message: l10n.changeMood,
                        child: Image.asset(
                          MoodManager.getAssetPath(_currentMoodKey),
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color:  Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        MoodManager.getTranslation(context, _currentMoodKey).toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: _noteController,
                    textAlign: TextAlign.center,
                    maxLines: null,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: l10n.noteHint,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}