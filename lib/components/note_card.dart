import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/mood_manager.dart';
import '../components/my_alert_dialog.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'package:mood_app/models/mood_entry.dart';
import 'package:mood_app/services/entry_service.dart';
import 'package:mood_app/models/activity_item.dart';

class NoteCard extends StatelessWidget {
  final MoodEntry entry;
  final VoidCallback onTap;

  NoteCard({
    super.key,
    required this.entry,
    required this.onTap,
  });

  final EntryService _entryService = EntryService();

  Future<void> _deleteEntry(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    showConfirmDialog(
      context: context,
      title: l10n.deleteTitle,
      message: l10n.deleteMessage,
      confirmText: l10n.deleteConfirm,
      cancelText: l10n.cancel,
      onConfirm: () async {
        try {
          await _entryService.deleteEntry(entry.id);
        } catch (e) {
          debugPrint("Error deleting: $e");
        }
      },
    );
  }

  Widget _buildActivityTags(BuildContext context) {
    if (entry.activities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: entry.activities.map((key) {
          final activity = getActivityByKey(key);

          if (activity == null) {
            return const SizedBox.shrink();
          }

          return Chip(
            label: Text(getActivityLabel(context, key)),
            avatar: Icon(
              activity.icon,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
            backgroundColor: Colors.white.withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            // дата и кнопка удаления
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('E', localeCode).format(entry.date),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      DateFormat('MM.dd').format(entry.date),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.black,
                    size: 22,
                  ),
                  onPressed: () => _deleteEntry(context),
                ),
              ],
            ),

            // эмодзи
            Center(
              child: Image.asset(
                MoodManager.getAssetPath(entry.moodKey),
                width: 100,
                height: 100,
              ),
            ),

            const SizedBox(height: 15),

            // статус
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  MoodManager.getTranslation(
                    context,
                    entry.moodKey,
                  ).toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // активности
            _buildActivityTags(context),

            if (entry.activities.isNotEmpty)
              const SizedBox(height: 15),

            // текст заметки
            if (entry.note.isNotEmpty)
              Center(
                child: Text(
                  entry.note,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}