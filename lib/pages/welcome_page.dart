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
    _quoteIndex = random.nextInt(44); 
    
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
      case 17: return l10n.quote18;
      case 18: return l10n.quote19;
      case 19: return l10n.quote20;
      case 20: return l10n.quote21;
      case 21: return l10n.quote22;
      case 22: return l10n.quote23;
      case 23: return l10n.quote24;
      case 24: return l10n.quote25;
      case 25: return l10n.quote26;
      case 26: return l10n.quote27;
      case 27: return l10n.quote28;
      case 28: return l10n.quote29;
      case 29: return l10n.quote30;
      case 30: return l10n.quote31;
      case 31: return l10n.quote32;
      case 32: return l10n.quote33;
      case 33: return l10n.quote34;
      case 34: return l10n.quote35;
      case 35: return l10n.quote36;
      case 36: return l10n.quote37;
      case 37: return l10n.quote38;
      case 38: return l10n.quote39;
      case 39: return l10n.quote40;
      case 40: return l10n.quote41;
      case 41: return l10n.quote42;
      case 42: return l10n.quote43;
      case 43: return l10n.quote44;
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
                  l10n.skip, 
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
                    _getTranslatedQuote(l10n), 
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