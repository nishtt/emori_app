import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_app/app.dart';
import 'package:mood_app/auth/login_or_register.dart';
import 'package:mood_app/pages/welcome_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _showWelcome = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Если мы еще показываем приветствие, возвращаем WelcomePage.
        // StreamBuilder при этом уже работает в фоне и получает данные о юзере.
        if (_showWelcome) {
          return WelcomePage(
            onFinish: () {
              setState(() {
                _showWelcome = false;
              });
            },
          );
        }

        // 2. Когда приветствие закончилось, проверяем состояние snapshot.
        // Если данных еще нет (connectionState == waiting), лучше показать пустой экран
        // или индикатор, но обычно за 5 секунд приветствия данные уже прилетают.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 3. Теперь переход будет мгновенным и правильным
        if (snapshot.hasData) {
          return const App();
        } else {
          return const LoginOrRegister();
        }
      },
    );
  }
}