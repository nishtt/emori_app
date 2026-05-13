import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:mood_app/auth/auth_gate.dart';
import 'package:mood_app/providers/mood_pack_provider.dart';
import 'package:mood_app/providers/theme_provider.dart';
import 'firebase_options.dart'; 
import 'providers/audio_provider.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'providers/locale_provider.dart'; 
import 'services/notification_service.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized(); 
  //подключение к Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //инициализация уведомлений
  await NotificationService.init();

  //загрузка набора эмодзи
 final moodPackProvider = MoodPackProvider();
  await moodPackProvider.loadPack();
  // загрузка темы
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => themeProvider),
      ChangeNotifierProvider(create: (_) => moodPackProvider),
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
    //текущая тема и язык
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

   
    return MaterialApp(
      title: 'Mood Tracker',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localeProvider.locale,
      home: const AuthGate(),
      theme: themeProvider.themeData,
    );
  }
}