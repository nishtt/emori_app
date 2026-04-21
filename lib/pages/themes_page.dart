import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_manager.dart';
import 'package:mood_app/l10n/app_localizations.dart';

class ThemesPage extends StatelessWidget {
  const ThemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(l10n.appThemes, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: themeManager.themeOptions.length,
        itemBuilder: (context, index) {
          final option = themeManager.themeOptions[index];
          // проверяем выбрана ли эта тема сейчас
          bool isSelected = themeManager.themeData == option.themeData;

          return GestureDetector(
            onTap: () => themeManager.setTheme(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1) 
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black,
                  width: isSelected ? 2 : 0.8,
                ),
              ),
              child: Row(
                children: [
                  
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: option.previewColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    option.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  if (isSelected) 
                    Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}