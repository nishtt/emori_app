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
  bool _showWelcome = true;//показывать экран приветствия

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {  
        if (_showWelcome) {
          return WelcomePage(
            onFinish: () {
              setState(() {
                _showWelcome = false;
              });
            },
          );
        }
        //загрузка
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // пользователь авторизован - показать основное приложение, иначе - экран входа/регистрации
        if (snapshot.hasData) {
          return const App();
        } else {
          return const LoginOrRegister();
        }
      },
    );
  }
}