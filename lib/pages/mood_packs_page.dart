import 'package:flutter/material.dart';
import '../themes/mood_themes.dart';

class MoodPacksPage extends StatefulWidget {
  const MoodPacksPage({super.key});

  @override
  State<MoodPacksPage> createState() => _MoodPacksPageState();
}

class _MoodPacksPageState extends State<MoodPacksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Choose Mood Pack", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MoodThemes.packs.length,
        itemBuilder: (context, index) {
          final pack = MoodThemes.packs[index];
          bool isSelected = MoodThemes.selectedPack.id == pack.id;

          return GestureDetector(
            onTap: () async {
              setState(() {
                MoodThemes.selectedPackNotifier.value = pack;
              });
              // сохраняем выбор в память устройства
              await MoodThemes.savePack(pack.id); 
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.2) : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black,
                  width: isSelected ? 2 : 0.8,
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    '${pack.basePath}happy.webp',
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.pets, size: 40),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    pack.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  if (isSelected) Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}