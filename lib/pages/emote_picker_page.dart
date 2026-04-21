import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'create_entry_page.dart';
import '../services/mood_manager.dart'; 
import 'package:mood_app/l10n/app_localizations.dart';

class EmotePickerPage extends StatelessWidget {
  final DateTime selectedDate;
  final bool isReturningMode;

  const EmotePickerPage({
    super.key, 
    required this.selectedDate, 
    this.isReturningMode = false, 
  });

  @override
  Widget build(BuildContext context) {
    final moodKeys = MoodManager.moodKeys;
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background, 
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        //закрытие
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        //дата
        title: Text(
          DateFormat('EEEE, MMM d', localeCode).format(selectedDate),
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            l10n.howAreYou,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          // сетка с эмодзи
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 25,
                crossAxisSpacing: 15,
                childAspectRatio: 0.8, 
              ),
              itemCount: moodKeys.length,
              itemBuilder: (context, index) {
                final String moodKey = moodKeys[index];
                
                return GestureDetector(
                  
                  onTap: () => _handleMoodSelection(context, moodKey),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          MoodManager.getAssetPath(moodKey),
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        MoodManager.getTranslation(context, moodKey), 
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  
  void _handleMoodSelection(BuildContext context, String moodKey) {
  if (isReturningMode) {
    // меняем эмодзи — отдаем данные назад
    Navigator.pop(context, {
      'moodKey': moodKey,
      'score': MoodManager.getScore(moodKey),
    });
  } else {
    // создаем новую запись — заменяем экран выбора экраном записи
    Navigator.pushReplacement( 
      context,
      MaterialPageRoute(
        builder: (context) => CreateEntryPage(
          date: selectedDate,
          moodKey: moodKey,
          score: MoodManager.getScore(moodKey),
          isEditing: false, 
        ),
      ),
    );
  }
}
}