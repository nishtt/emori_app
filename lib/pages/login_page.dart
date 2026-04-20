import 'package:flutter/material.dart';
import 'package:mood_app/auth/auth_service.dart';
import 'package:mood_app/components/my_button.dart';
import 'package:mood_app/components/my_textfield.dart';
import 'package:mood_app/pages/forgot_pw_page.dart';
import 'package:mood_app/components/my_alert_dialog.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  
  // индикатор загрузки
  bool _isLoading = false;

  void login(BuildContext context) async {
    final authService = AuthService();

    // валидация на пустые поля
    if (_emailController.text.isEmpty || _pwController.text.isEmpty) {
      showMyDialog(
        context: context,
        title: "Login Error",
        message: "Please enter both email and password.",
      );
      return;
    }

    // включаем индикатор загрузки
    setState(() => _isLoading = true);
    //вход
    try {
      await authService.signInWithEmailPassword(
        _emailController.text.trim(), 
        _pwController.text.trim()
      );
    } catch (e) {
      if (mounted) {
        showMyDialog(
          context: context,
          title: "Login Failed",
          message: e.toString().replaceAll("Exception: ", ""),
        );
      }
    } finally {
      // выключаем индикатор 
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //вход
              Text(
                "Login",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 32,
                ),
              ),

              const SizedBox(height: 25),
              //поле email
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),

              const SizedBox(height: 25),
              //поле пароль
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _pwController,
              ),

              const SizedBox(height: 15),

              // восстановление пароля
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                        );
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // кнопка логина с проверкой загрузки
              _isLoading 
                ? const CircularProgressIndicator() 
                : MyButton(
                    text: "Login",
                    onTap: () => login(context),
                  ),

              const SizedBox(height: 20),

              // переход на регистрацию
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not registered yet?"),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: widget.onTap, 
                    child: const Text(
                      "Register now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.0,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}