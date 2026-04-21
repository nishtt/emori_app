import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:mood_app/auth/auth_gate.dart';
import 'package:mood_app/models/mood_pack.dart';
import 'package:mood_app/themes/mood_themes.dart';
import 'package:mood_app/services/theme_manager.dart';
import 'firebase_options.dart'; 
import 'services/audio_provider.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'services/locale_provider.dart'; 
import 'services/notification_service.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  await NotificationService.requestPermissions();
  await MoodThemes.loadPack();

  final themeManager = ThemeManager();
  await themeManager.loadTheme();

  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => themeManager),
      ChangeNotifierProvider(create: (_) => AudioProvider()), 
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ],
    child: const MoodTrackerApp(),
  ),
);
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {

    final themeManager = Provider.of<ThemeManager>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return ValueListenableBuilder<MoodPack>(
      valueListenable: MoodThemes.selectedPackNotifier,
      builder: (context, pack, child) {
        return MaterialApp(
          title: 'Mood Tracker',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
          home: const AuthGate(),
          theme: themeManager.themeData,  
        );
      }, 
    ); 
  }
}