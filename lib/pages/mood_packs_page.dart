import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mood_pack_provider.dart';
import 'package:mood_app/l10n/app_localizations.dart';

class MoodPacksPage extends StatelessWidget {
  const MoodPacksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final moodPackProvider = Provider.of<MoodPackProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          l10n.chooseMoodPack,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: moodPackProvider.packs.length,
        itemBuilder: (context, index) {
          final pack = moodPackProvider.packs[index];
          final isSelected = moodPackProvider.currentPack.id == pack.id;

          return GestureDetector(
            onTap: () {
              moodPackProvider.setPack(pack);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black,
                  width: isSelected ? 2 : 0.8,
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    '${pack.basePath}happy.webp',
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.pets, size: 40),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    pack.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}