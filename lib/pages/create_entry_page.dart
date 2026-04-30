import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/mood_manager.dart';
import 'emote_picker_page.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'package:mood_app/services/entry_service.dart';
import 'package:mood_app/models/mood_entry.dart';
import 'package:mood_app/pages/activities_picker_page.dart';
import 'package:mood_app/models/activity_item.dart';
import 'package:mood_app/components/my_alert_dialog.dart';

enum EntryMode {
  create,
  edit,
}

class CreateEntryPage extends StatefulWidget {
  final DateTime date;
  final String moodKey;
  final int score;
  final String? initialText;
  final List<String> initialActivities;
  final EntryMode mode;

  const CreateEntryPage({
    super.key,
    required this.date,
    required this.moodKey,
    required this.score,
    this.initialText,
    this.initialActivities = const [],
    this.mode = EntryMode.create,
  });

  @override
  State<CreateEntryPage> createState() => _CreateEntryPageState();
}

class _CreateEntryPageState extends State<CreateEntryPage> {
  final EntryService _entryService = EntryService();

  late TextEditingController _noteController;
  late String _currentMoodKey;
  late int _currentScore;
  late List<String> _selectedActivities;

  @override
  void initState() {
    super.initState();

    _noteController = TextEditingController(text: widget.initialText ?? "");
    _currentMoodKey = widget.moodKey;
    _currentScore = widget.score;
    _selectedActivities = List<String>.from(widget.initialActivities);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _closePage() {
    if (widget.mode == EntryMode.edit) {
      Navigator.pop(context);
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  Future<void> _changeMood() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmotePickerPage(
          selectedDate: widget.date,
          isReturningMode: true,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _currentMoodKey = result['moodKey'];
        _currentScore = result['score'];
      });
    }
  }

  Future<void> _openActivitiesPicker() async {
    FocusScope.of(context).unfocus();

    final result = await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(
        builder: (context) => ActivitiesPickerPage(
          selectedActivities: _selectedActivities,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedActivities = result;
      });
    }
  }

  bool _isSaving = false;

  Future<void> _saveEntry() async {
    if (_isSaving) return;
    
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isSaving = true);

    try {
      final docId = _entryService.generateEntryId(widget.date);

      final entry = MoodEntry(
        id: docId,
        date: widget.date,
        moodKey: _currentMoodKey,
        score: _currentScore,
        note: _noteController.text.trim(),
        activities: _selectedActivities,
      );

      await _entryService.saveEntry(entry);

      if (mounted) {
        _closePage();
      }
    } catch (e) {
      if (mounted) {
        showMyDialog(
          context: context,
          title: l10n.error,
          message: e.toString().replaceAll("Exception: ", ""),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Widget _buildActivityTags() {
    if (_selectedActivities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: _selectedActivities.map((key) {
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
            backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5), 
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
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: _closePage,
        ),
        actions: [
          TextButton(
            onPressed: _saveEntry,
            child: Text(
              l10n.save,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('E.', localeCode).format(widget.date),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            DateFormat('MM.dd').format(widget.date),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: _openActivitiesPicker,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Center(
                    child: GestureDetector(
                      onTap: _changeMood,
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
                          _currentMoodKey,
                        ).toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  _buildActivityTags(),

                  if (_selectedActivities.isNotEmpty)
                    const SizedBox(height: 15),

                  TextField(
                    controller: _noteController,
                    textAlign: TextAlign.center,
                    maxLines: null,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.noteHint,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
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