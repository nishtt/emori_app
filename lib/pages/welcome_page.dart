import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mood_app/l10n/app_localizations.dart'; // Импорт локализации

class WelcomePage extends StatefulWidget {
  final VoidCallback onFinish;

  const WelcomePage({super.key, required this.onFinish});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _quoteIndex = 0; // Храним индекс, а не готовую строку
  late String _randomAnim;
  Timer? _timer;

  final List<String> _animations = [
    'assets/animations/sun.webp',
    'assets/animations/cloud.webp',
    'assets/animations/flower.webp',
  ];

  @override
  void initState() {
    super.initState();
    final random = Random();
    
    // Выбираем случайный индекс для цитаты
    _quoteIndex = random.nextInt(17); 
    
    _randomAnim = _animations[random.nextInt(_animations.length)];

    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        widget.onFinish();
      }
    });
  }

  // Вспомогательный метод для получения текста цитаты по индексу
  String _getTranslatedQuote(AppLocalizations l10n) {
    switch (_quoteIndex) {
      case 0: return l10n.quote1;
      case 1: return l10n.quote2;
      case 2: return l10n.quote3;
      case 3: return l10n.quote4;
      case 4: return l10n.quote5;
      case 5: return l10n.quote6;
      case 6: return l10n.quote7;
      case 7: return l10n.quote8;
      case 8: return l10n.quote9;
      case 9: return l10n.quote10;
      case 10: return l10n.quote11;
      case 11: return l10n.quote12;
      case 12: return l10n.quote13;
      case 13: return l10n.quote14;
      case 14: return l10n.quote15;
      case 15: return l10n.quote16;
      case 16: return l10n.quote17;
      default: return l10n.quote1;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: TextButton(
                onPressed: widget.onFinish,
                child: Text(
                  l10n.skip, // Локализованный текст "Пропустить"
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  Center(
                    child: Image.asset(
                      _randomAnim,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.wb_sunny_outlined, size: 100, color: Colors.orange),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _getTranslatedQuote(l10n), // Вывод переведенной цитаты
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
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