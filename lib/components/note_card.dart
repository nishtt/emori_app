import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/mood_manager.dart'; 
import '../components/my_alert_dialog.dart';
import 'package:mood_app/l10n/app_localizations.dart';


class NoteCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;

  const NoteCard({super.key, required this.data, required this.onTap});

  // функция удаления записи
  Future<void> _deleteEntry(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final l10n = AppLocalizations.of(context)!;
    if (user == null) return;

    //окно подтверждения удаления
    showConfirmDialog(
    context: context,
    title: l10n.deleteTitle,
    message: l10n.deleteMessage,
    confirmText: l10n.deleteConfirm,
    cancelText: l10n.cancel,
    onConfirm: () async {
      
      try {
        final date = (data['date'] as Timestamp).toDate();
        String docId = DateFormat('yyyy-MM-dd').format(date);
        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('entries')
            .doc(docId)
            .delete();
            
      } catch (e) {
        debugPrint("Error deleting: $e");
      }
    },
  );
  }

  @override
Widget build(BuildContext context) {
  final date = (data['date'] as Timestamp).toDate();
  final moodKey = data['moodKey'] ?? 'neutral';
  final l10n = AppLocalizations.of(context)!;
  final localeCode = Localizations.localeOf(context).languageCode;

  return GestureDetector(
    onTap: onTap, 
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5), 
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //дата
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('E', localeCode).format(date),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                  ),
                  Text(
                    DateFormat('MM.dd').format(date),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              //кнопка удаления
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.cancel_outlined, color: Colors.black, size: 22),
                onPressed: () => _deleteEntry(context), 
              ),
            ],
          ),

          //эмодзи
          Center(
            child: Image.asset(
              MoodManager.getAssetPath(moodKey),
              width: 100, 
              height: 100,
            ),
          ),

          const SizedBox(height: 15),
          //статус
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                MoodManager.getTranslation(context, moodKey).toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          
          const SizedBox(height: 15),
          
        //текст заметки
        if (data['note'] != null && data['note'].toString().isNotEmpty)
          Center(
            child: Text(
              data['note'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15, 
                height: 1.5, 
                color: Colors.black87
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
  
}